<template>
  <div class="py-12">
    <panel title="Tes input & form detail">
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
                    :allow-updating="Access.AllowEdit"
                    :allow-adding="false"
                    :allow-deleting="false"
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
                    <DxItem :editor-options="{value: '',searchEnabled: true,items: sectors,}" :validation-rules="validationRules.position" data-field="Sector" editor-type="dxSelectBox"/> 
                    <DxItem :editor-options="{value: '',searchEnabled: true,items: estates,}" :validation-rules="validationRules.position" data-field="Estate" editor-type="dxSelectBox"/>
                    <DxItem data-field="Featno" :validation-rules="validationRules.position"/>
                    <DxItem data-field="Kategori" />
                    <DxItem data-field="Sitetype" :visible="isVis" />
                    <DxItem data-field="Landcover" :visible="isVis" />
                    <DxItem data-field="Replant" :visible="isVis2" />
                    <DxItem data-field="Jenisbelukar" :visible="isVis" />
                    </DxForm>
                </DxEditing>
                <!-- End Create Setting-->

                <!-- DATA TABLE -->
                <DxColumn
                    type="buttons"
                    :width="50"
                    :fixed="true"
                    caption="Upload"
                    :visible="Access.AllowEdit"
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
                    :set-cell-value="setKategoriValue"
                    :width="125"
                    data-field="Kategori"
                    caption="Kategori"
                    data-type="string"
                    header-cell-template="template-header"
                >
                    <DxLookup
                    :data-source="kategori"
                    value-expr="kategori"
                    display-expr="kategori"
                    />
                </DxColumn>
                <DxColumn
                    data-field="Sitetype"
                    data-type="string"
                    header-cell-template="template-header"
                    caption="Site Type"
                >
                    <DxLookup 
                    :data-source="getFilteredSitetype" 
                    value-expr="sitetype" 
                    display-expr="sitetype"
                    />
                </DxColumn>
                <DxColumn
                    data-field="Landcover"
                    data-type="string"
                    header-cell-template="template-header"
                    caption="Land Cover"
                >
                    <DxLookup 
                    :data-source="getFilteredLandcover" 
                    value-expr="landcover" 
                    display-expr="landcover"
                    />
                </DxColumn>
                <DxColumn
                    data-field="Replant"
                    data-type="string"
                    header-cell-template="template-header"
                    caption="Replant"
                >
                    <DxLookup 
                    :data-source="getFilteredReplant" 
                    value-expr="replant" 
                    display-expr="replant"
                    />
                </DxColumn>
                <DxColumn
                    data-field="Jenisbelukar"
                    data-type="string"
                    header-cell-template="template-header"
                    caption="Jenis Belukar"
                >
                </DxColumn>

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
  DxLookup,
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
const sectors = ['AEM','BJA','CKM','DHM','INH','LNP','MAJ','MPS','MSB','NKL','PBA','PBB','PNB','PHK','SAK','SBA','TAB','TMB','TJY','TPH',"KEM", "KBB"];
const estates = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
const sitetype = [
  {kategori: 'Register', sitetype: 'Dry'},
  {kategori: 'Register', sitetype: 'Wet'}
];
const landcover = [
  {kategori: 'Register', landcover:'Acacia Land'},
  {kategori: 'Register', landcover:'Agricultural Land'},
  {kategori: 'Register', landcover:'Burned Area'},
  {kategori: 'Register', landcover:'Cleared Land'},
  {kategori: 'Register', landcover:'Clearcut Area'},
  {kategori: 'Register', landcover:'Coppice in Eucalyptus Land'},
  {kategori: 'Register', landcover:'Eucalyptus Land'},
  {kategori: 'Register', landcover:'Grass Land'},
  {kategori: 'Register', landcover:'Low-yield Forest'},
  {kategori: 'Register', landcover:'Mixed Hardwood Forest'},
  {kategori: 'Register', landcover:'Oil Palm'},
  {kategori: 'Register', landcover:'Others'},
  {kategori: 'Register', landcover:'Pinus Land'},
  {kategori: 'Register', landcover:'Rubber'},
  {kategori: 'Register', landcover:'Scrub Land'},
  {kategori: 'Register', landcover:'Unknown'}
];
const replant = [
  {kategori: 'Register', replant:'ACRA'},{kategori: 'Register', replant:'AHYB'},{kategori: 'Register', replant:'AEXE'},{kategori: 'Register', replant:'ALMA'},
  {kategori: 'Register', replant:'AMAN'},{kategori: 'Register', replant:'AMEA'},{kategori: 'Register', replant:'ANCA'},{kategori: 'Register', replant:'AULA'},
  {kategori: 'Register', replant:'AURA'},{kategori: 'Register', replant:'BAMB'},{kategori: 'Register', replant:'CALI'},{kategori: 'Register', replant:'CASU'},
  {kategori: 'Register', replant:'CHYH'},{kategori: 'Register', replant:'COCO'},{kategori: 'Register', replant:'CUTA'},{kategori: 'Register', replant:'DUMO'},
  {kategori: 'Register', replant:'DURI'},{kategori: 'Register', replant:'EGAU'},{kategori: 'Register', replant:'ELGU'},{kategori: 'Register', replant:'EUAG'},
  {kategori: 'Register', replant:'EUCY'},{kategori: 'Register', replant:'GARO'},{kategori: 'Register', replant:'HVEA'},{kategori: 'Register', replant:'MELA'},
  {kategori: 'Register', replant:'MEMI'},{kategori: 'Register', replant:'MESA'},{kategori: 'Register', replant:'MHW'},{kategori: 'Register', replant:'OSMA'},
  {kategori: 'Register', replant:'OTHE'},{kategori: 'Register', replant:'PAFA'},{kategori: 'Register', replant:'PCAR'},{kategori: 'Register', replant:'PECA'},
  {kategori: 'Register', replant:'PELT'},{kategori: 'Register', replant:'PINE'},{kategori: 'Register', replant:'PMER'},{kategori: 'Register', replant:'PPAT'},
  {kategori: 'Register', replant:'PTEC'},{kategori: 'Register', replant:'SMAC'},{kategori: 'Register', replant:'SMIX'},{kategori: 'Register', replant:'SORY'},
  {kategori: 'Register', replant:'TGRA'},{kategori: 'Register', replant:'TUP'},{kategori: 'Register', replant:'UNKN'},
  {kategori: 'Split', replant:'ACRA'},{kategori: 'Split', replant:'AHYB'},{kategori: 'Split', replant:'AEXE'},{kategori: 'Split', replant:'ALMA'},
  {kategori: 'Split', replant:'AMAN'},{kategori: 'Split', replant:'AMEA'},{kategori: 'Split', replant:'ANCA'},{kategori: 'Split', replant:'AULA'},
  {kategori: 'Split', replant:'AURA'},{kategori: 'Split', replant:'BAMB'},{kategori: 'Split', replant:'CALI'},{kategori: 'Split', replant:'CASU'},
  {kategori: 'Split', replant:'CHYH'},{kategori: 'Split', replant:'COCO'},{kategori: 'Split', replant:'CUTA'},{kategori: 'Split', replant:'DUMO'},
  {kategori: 'Split', replant:'DURI'},{kategori: 'Split', replant:'EGAU'},{kategori: 'Split', replant:'ELGU'},{kategori: 'Split', replant:'EUAG'},
  {kategori: 'Split', replant:'EUCY'},{kategori: 'Split', replant:'GARO'},{kategori: 'Split', replant:'HVEA'},{kategori: 'Split', replant:'MELA'},
  {kategori: 'Split', replant:'MEMI'},{kategori: 'Split', replant:'MESA'},{kategori: 'Split', replant:'MHW'},{kategori: 'Split', replant:'OSMA'},
  {kategori: 'Split', replant:'OTHE'},{kategori: 'Split', replant:'PAFA'},{kategori: 'Split', replant:'PCAR'},{kategori: 'Split', replant:'PECA'},
  {kategori: 'Split', replant:'PELT'},{kategori: 'Split', replant:'PINE'},{kategori: 'Split', replant:'PMER'},{kategori: 'Split', replant:'PPAT'},
  {kategori: 'Split', replant:'PTEC'},{kategori: 'Split', replant:'SMAC'},{kategori: 'Split', replant:'SMIX'},{kategori: 'Split', replant:'SORY'},
  {kategori: 'Split', replant:'TGRA'},{kategori: 'Split', replant:'TUP'},{kategori: 'Split', replant:'UNKN'}
];
const Kategori = [{ kategori: 'Register' }, { kategori: 'Split' },{ kategori: 'PCCR' }];
export default {
  components: {
    DxLookup,
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
    const formData = {};
    const isVis = false;
    const isVis2 = false;
    const store = new CustomStore({
      key: 'id',
      load: function () {
        return CrudService.getAll('changecompt/index');
      },
      
    });

    return {
      dataSource: store,
      dataGridRef,
      estates,
      sectors,
      Access,
      VAccess,
      header,
      DataReq,
      formData,
      Grid,
      fileAdded,
      kategori: Kategori,
      isVis,
      isVis2,
      validationRules: {
        position: [{ type: 'required', message: 'Required.' }],
      },
      setKategoriValue: (rowData, value) => {
        rowData.Kategori = value;
        this.setVis((value !== 'Split')&&(value !== 'PCCR'));
        this.setVis2((value !== 'PCCR'));
      },
    };
  },

  methods: {
    setVis(vis) {
      this.isVis = vis;
    },
    setVis2(vis2) {
      this.isVis2 = vis2;
    },
    getFilteredSitetype: (options) => {
      return {
        store: sitetype,
        filter: options.data ? ['kategori', '=', options.data.Kategori] : null,
      };
    },
    getFilteredLandcover: (options) => {
      return {
        store: landcover,
        filter: options.data ? ['kategori', '=', options.data.Kategori] : null,
      };
    },
    getFilteredReplant: (options) => {
      return {
        store: replant,
        filter: options.data ? ['kategori', '=', options.data.Kategori] : null,
      };
    },

    onExporting(e) {
      const workbook = new ExcelJS.Workbook();
      const worksheet = workbook.addWorksheet('Registersplitinput');

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
        },
        {						
            location: 'after',
            widget: 'dxButton',
            options: {
                hint: 'Add New Request',
                icon: 'add',
                onClick: this.changecomptadd.bind(this),
            }
        }
      );
    },
    refreshDataGrid() {
      this.Grid.refresh();
    },
    changecomptadd() {
      this.$router.push('/Changecompt')
    },
    onInitialized(e) {
      this.Grid = e.component;
    },
  },
  created() {
    CrudService.findData('accessroles/check', { module: 'Changecompt' }).then(
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

