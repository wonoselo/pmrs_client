<template>
  <div class="py-12">
    <panel title="Form Input Request">
      <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
        <DxDataGrid
          @toolbar-preparing="onToolbarPreparing($event)"
          column-resizing-mode="widget"
          @initialized="onInitialized"
          :data-source="dataSource"
          :allow-column-resizing="true"
          :show-borders="true"
          :show-column-lines="true"
          :remote-operations="false"
          :row-alternation-enabled="true"
          :column-hiding-enabled="true"
        >
          <!-- Edit Setting-->
          <DxEditing
            :allow-updating="false"
            :allow-adding="Access.AllowAdd"
            :allow-deleting="Access.AllowDelete"
            :use-icons="true"
            mode="popup"
          >
            <DxPopup
              :show-title="true"
              :width="850"
              :height="725"
              title="Form Add"
            >
              <DxPosition my="center" at="center" of="window" />
            </DxPopup>
            <DxForm>
              <DxItem
                :editor-options="{
                  value: '',
                  searchEnabled: true,
                  items: sectors,
                }"
                :validation-rules="validationRules.position"
                data-field="Sector"
                editor-type="dxSelectBox"
              /> 
              <DxItem
                :editor-options="{
                  value: '',
                  searchEnabled: true,
                  items: estates,
                }"
                :validation-rules="validationRules.position"
                data-field="Estate"
                editor-type="dxSelectBox"
              />
              <DxItem data-field="Featno" :validation-rules="validationRules.position"/>
              <DxItem
                :editor-options="{
                  value: '',
                  searchEnabled: true,
                  items: positions,
                }"
                :validation-rules="validationRules.position"
                data-field="Pola"
                editor-type="dxSelectBox"
              />
              <DxItem data-field="Nama_Claimer" :validation-rules="validationRules.position"/>
              <DxItem data-field="No_KTP_Claimer" :validation-rules="validationRules.position" />
              <DxItem data-field="Luas"
              :editor-options="{
                  format:'#,####0.## Ha',
                  showClearButton: true
                }" 
              :validation-rules="validationRules.position"
              />
            </DxForm>
          </DxEditing>
          <!-- End Create Setting-->

          <!-- DATA TABLE -->
          <DxColumn
            type="buttons"
            :width="50"          
            :fixed="true"
            caption="Delete"
            :visible="Access.AllowDelete"
            fixed-position="left"
            header-cell-template="template-header"
            :allow-fixing="false"
          />
          <DxColumn
            data-field="Sector"
            data-type="string"
            caption="Sector"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Estate"
            data-type="string"
            caption="Estate"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Featno"
            data-type="string"
            caption="FeatNo"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Pola"
            data-type="string"
            caption="Pola"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Nama_Claimer"
            data-type="string"
            caption="Nama Claimer"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="No_KTP_Claimer"
            data-type="string"
            caption="No KTP Claimer"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Luas"
            data-type="number"
            format="#,####0.## Ha"
            header-cell-template="template-header"
          />

          <!-- END DATA TABLE -->

          <DxExport :enabled="true" :allow-export-selected-data="true" />
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
  DxPosition,
  DxForm,
  DxExport,
  DxSearchPanel,
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
import LocalStorageService from '../LocalStorageService';
const localStorageService = LocalStorageService.getService();
const dataGridRef = 'data-grid';
const positions = ['PHBM','Peralihan PHBM ke Tali Asih', 'Tali Asih', 'GRTT', 'Tanaman Buah', 'Pembebasan Koridor','Pembelian Lahan Logpond'];
const sectors = ['AEM','BJA','CKM','DHM','INH','LNP','MAJ','MPS','MSB','NKL','PBA','PBB','PNB','PHK','SAK','SBA','TAB','TMB','TJY','TPH',"KEM", "KBB"];
const estates = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','-'];
export default {
  components: {
    DxItem,
    DxDataGrid,
    DxColumn,
    DxPaging,
    DxPager,
    DxEditing,
    DxPopup,
    DxPosition,
    DxForm,
    DxSearchPanel,
    DxExport,
    DxColumnFixing,
    DxHeaderFilter,
    DxFilterRow,
  },
  props: ['data', 'flash'],
  data() {
    const Access = {
      AllowView: false,
      AllowAdd: false,
      AllowEdit: false,
      AllowDelete: false,
    };
    const VAccess = {
      AllowView: false,
      AllowAdd: false,
      AllowEdit: false,
      AllowDelete: false,
    };
    const token = localStorageService.getAccessToken();
    const header = { Authorization: 'Bearer ' + token };
    const DataReq = {};
    const fileAdded = false;
    const Grid = {};
    const store = new CustomStore({
      key: 'id',
      load: function () {
        return CrudService.getAll('reqssl');
      },
      insert: (key, values) => {
        return CrudService.insertData('reqssl', key, values);
      },
      remove: (key) => {
      return CrudService.removeData('reqssl/delete', key);
      },
    });

    return {
      dataSource: store,
      dataGridRef,
      estates,
      sectors,
      positions,
      Access,
      VAccess,
      header,
      DataReq,
      Grid,
      fileAdded,
      validationRules: {
        position: [{ type: 'required', message: 'Required.' }],
      },
    };
  },

  methods: {

    onExporting(e) {
      const workbook = new ExcelJS.Workbook();
      const worksheet = workbook.addWorksheet('Reqssl');

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
      this.Grid.refresh();
    },
    onInitialized(e) {
      this.Grid = e.component;
    },
  },
  created() {
    CrudService.findData('accessroles/check', { module: 'ReqSsl' }).then(
      (response) => {
        this.Access = response.data;
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

