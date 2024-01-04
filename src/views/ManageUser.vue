<template>
  <div class="py-12">
    <panel title="Manage User">
      <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
        <DxDataGrid
          @toolbar-preparing="onToolbarPreparing($event)"
          :ref="dataGridRef"
          :data-source="dataSource"
          :allow-column-resizing="true"
          :show-borders="true"
          :show-column-lines="true"
          @editing-start="onEditingStart"
          :remote-operations="false"
          :row-alternation-enabled="true"
          :column-hiding-enabled="true"
        >
          <DxEditing
            :allow-updating="Access.AllowEdit"
            :allow-adding="Access.AllowAdd"
            :allow-deleting="Access.AllowDelete"
            :use-icons="true"
            mode="popup"
          >
            <DxPopup :show-title="true" title="Edit User">
              <DxPosition my="top" at="top" of="window" />
            </DxPopup>
            <DxForm>
              <DxItem data-field="username" />
              <DxItem data-field="email" />
              <DxItem data-field="fullname" />
              <DxItem data-field="bu" />
              <DxItem data-field="role_id" />
              <DxItem data-field="region" :visible="isVis" />
              <DxItem data-field="isAdmin" />
              <DxItem data-field="isActivated" />
            </DxForm>
          </DxEditing>
          <DxColumn
            type="buttons"
            :width="40"
            :fixed="true"
            fixed-position="left"
            :allow-fixing="false"
          />
          <DxColumn
            :width="40"
            :allow-grouping="false"
            :allow-filtering="false"
            :allow-editing="false"
            :fixed="true"
            :visible="Access.AllowEdit"
            fixed-position="left"
            :allow-fixing="false"
            data-field="id"
            caption=" "
            cell-template="resetTemplate"
          />
          <DxColumn
            data-field="username"
            data-type="string"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="email"
            data-type="string"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="fullname"
            data-type="string"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="role_id"
            data-type="integer"
            caption="Role"
            header-cell-template="template-header"
          >
            <DxLookup
              :data-source="role"
              value-expr="id"
              display-expr="RoleName"
            />
          </DxColumn>
          <DxColumn
            :set-cell-value="setBUValue"
            data-field="bu"
            data-type="string"
            header-cell-template="template-header"
            caption="BU"
          >
            <DxLookup 
              :data-source="bu" 
              value-expr="bu" 
              display-expr="bu" 
            />
          </DxColumn>
          <DxColumn
            data-field="region"
            data-type="string"
            header-cell-template="template-header"
            caption="Region"
          >
            <DxLookup 
              :data-source="getFilteredRegion" 
              value-expr="region" 
              display-expr="region"
            />
          </DxColumn>
          <DxColumn
            data-field="isAdmin"
            data-type="boolean"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="isActivated"
            data-type="boolean"
            header-cell-template="template-header"
          />
          <DxExport :enabled="true" :allow-export-selected-data="true" />
          <DxColumnChooser :enabled="true" />
          <DxColumnFixing :enabled="false" />
          <DxSearchPanel :visible="true" :highlight-case-sensitive="true" />
          <DxHeaderFilter :visible="true" />
          <DxFilterRow :visible="true" />
          <DxPaging :page-size="20" />
          <DxPager
            :show-page-size-selector="true"
            :allowed-page-sizes="[20, 50, 100]"
          />
          <template #template-header="{ data }">
            <span style="color: navy; font-weight: bold; font-size: 9pt">{{
              data.column.caption
            }}</span>
          </template>
          <template #resetTemplate="{ data: cellData }">
            <DxButton
              :cell-data="cellData"
              hint="Reset Password"
              styling-mode="text"
              icon="repeat"
              type="default"
              @click="resetIconClick(cellData)"
            />
          </template>
        </DxDataGrid>
      </div>
    </panel>
  </div>
</template>
<script>
import {
  DxDataGrid,
  DxColumn,
  DxPaging,
  DxPager,
  DxEditing,
  DxPopup,
  DxLookup,
  DxPosition,
  DxForm,
  DxExport,
  DxSearchPanel,
  DxColumnChooser,
  DxColumnFixing,
  DxHeaderFilter,
  DxFilterRow,
} from 'devextreme-vue/data-grid';
import CustomStore from 'devextreme/data/custom_store';
import { exportDataGrid } from 'devextreme/excel_exporter';
import ExcelJS from 'exceljs';
import saveAs from 'file-saver';
import { DxItem } from 'devextreme-vue/form';
import CrudService from '../services/crud.service';
import notify from 'devextreme/ui/notify';
import { alert, confirm } from 'devextreme/ui/dialog';
import DxButton from 'devextreme-vue/button';
const dataGridRef = 'data-grid';
const store = new CustomStore({
  key: 'id',
  load: function () {
    return CrudService.getAll('users');
  },
  insert: (values) => {
    return CrudService.insertData('users', values);
  },
  remove: (key) => {
    return CrudService.removeData('users/delete', key);
  },
  update: (key, values) => {
    return CrudService.updateData('users', key, values);
  },
});
const bu = [{ bu: 'HO' }, { bu: 'FNH' }];
const regions = [
  { bu: 'FNH', region: 'NORTH 1' },
  { bu: 'FNH', region: 'NORTH 2' },
  { bu: 'FNH', region: 'NORTH 3' },
  { bu: 'FNH', region: 'SOUTH 1' },
  { bu: 'FNH', region: 'SOUTH 2' },
  { bu: 'FNH', region: 'ACRA PLANTATION (HTI-HA Kalteng)' },
  { bu: 'FNH', region: 'GLOBAL PLANTATION (HTI-HTR-HR Gorontalo dan Sulut)' },
];

export default {
  components: {
    DxDataGrid,
    DxColumn,
    DxPaging,
    DxPager,
    DxEditing,
    DxPopup,
    DxLookup,
    DxPosition,
    DxForm,
    DxSearchPanel,
    DxExport,
    DxItem,
    DxColumnChooser,
    DxColumnFixing,
    DxHeaderFilter,
    DxFilterRow,
    DxButton,
  },
  props: ['data', 'flash'],
  data() {
    const role = {};
    const Access = {
      AllowView: true,
      AllowAdd: true,
      AllowEdit: true,
      AllowDelete: true,
    };
    const isVis = true;
    return {
      dataSource: store,
      dataGridRef,
      role,
      bu: bu,
      Access,
      isVis,
      setBUValue: (rowData, value) => {
        rowData.region = '';
        rowData.bu = value;
        this.setVis(value !== 'HO');
      },
    };
  },
  methods: {
    setVis(vis) {
      this.isVis = vis;
    },
    onExporting(e) {
      const workbook = new ExcelJS.Workbook();
      const worksheet = workbook.addWorksheet('Users');

      exportDataGrid({
        component: e.component,
        worksheet: worksheet,
        autoFilterEnabled: true,
      }).then(() => {
        workbook.xlsx.writeBuffer().then((buffer) => {
          saveAs(
            new Blob([buffer], { type: 'application/octet-stream' }),
            'DataGrid.xlsx'
          );
        });
      });
      e.cancel = true;
    },
    onEditingStart(e) {
      console.log(e);
      this.isVis = e.data.bu !== 'HO';
    },
    resetIconClick(e) {
      if (this.Access.AllowEdit) {
        const id = e.row.data.id;
        const user = e.row.data;
        let result = confirm(
          '<i>Are you sure to reset this user : <b>' +
            user.fullname +
            '</b> password?</i>',
          'Confirm changes'
        );
        result.then((dialogResult) => {
          if (dialogResult) {
            CrudService.findData('users/reset/' + id, { user }).then(
              (response) => {
                if (response.status == 'success') {
                  notify(
                    {
                      message: 'User password has been reset',
                      width: 300,
                      height: 80,
                      position: {
                        my: 'top center',
                        at: 'center center',
                        of: window,
                        offset: '0 0',
                      },
                    },
                    'success',
                    1000
                  );
                } else {
                  notify(
                    {
                      message: response.message,
                      width: 300,
                      height: 80,
                      position: {
                        my: 'top center',
                        at: 'center center',
                        of: window,
                        offset: '0 0',
                      },
                    },
                    'error',
                    1000
                  );
                }
              }
            );
          } else {
            notify(
              {
                message: 'Password reset canceled',
                width: 300,
                height: 80,
                position: {
                  my: 'top center',
                  at: 'center center',
                  of: window,
                  offset: '0 0',
                },
              },
              'info',
              1000
            );
          }
        });
      } else {
        alert("You don't have access to reset user password", 'Error');
      }
    },
    getFilteredRegion: (options) => {
      return {
        store: regions,
        filter: options.data ? ['bu', '=', options.data.bu] : null,
      };
    },
    onEditorPreparing(e) {
      if (e.parentType === 'dataRow' && e.dataField === 'region') {
        e.editorOptions.disabled = typeof e.row.data.bu !== 'number';
      }
    },
    onToolbarPreparing(e) {
      e.toolbarOptions.items.unshift({
        location: 'after',
        widget: 'dxButton',
        options: {
          icon: 'refresh',
          onClick: this.refreshDataGrid.bind(this),
        },
      });
    },
    refreshDataGrid() {
      this.DataGrid.refresh();
    },
  },
  computed: {
    DataGrid: function () {
      return this.$refs[dataGridRef].instance;
    },
  },
  mounted() {
    CrudService.getAll('roles').then((response) => {
      this.role = response.data;
    });
  },
  created() {
    CrudService.findData('accessroles/check').then(
      (response) => {
        this.Access = response.data;
        console.log(this.Access)
        console.log(response)
        if (response.isadmin)
          this.Access = {
            AllowView: true,
            AllowAdd: true,
            AllowEdit: true,
            AllowDelete: true,
          };
      }
    );
  },
};
</script>
