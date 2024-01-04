<template>
  <div class="py-12">
    <panel title="Monitoring Report">
      <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
        <div class="card bg-light border-0 text-white">
          <div class="card-body">
            <form action="#" @submit="handleSubmit">
              <DxForm
                :form-data="period"
                :read-only="false"
                col-count="2"
                :show-colon-after-label="true"
                :show-validation-summary="true"
              >
                <!-- <DxSimpleItem
                  data-field="SECTOR"
                  
                  editor-type="dxSelectBox"
                />
                <DxSimpleItem
                  data-field="EndDate"
                  editor-type="dxDateBox"
                  :editor-options="{
                    type: 'date',
                    displayFormat: 'dd/MM/yyyy',
                  }"
                /> -->
                <DxButtonItem
                  :button-options="buttonOptions"
                  horizontal-alignment="left"
                />
              </DxForm>
            </form>
          </div>
        </div>
        <div class="card">
          <div class="card-body">
            <DxDataGrid
              @toolbar-preparing="onToolbarPreparing($event)"
              :ref="dataGridRef"
              :data-source="dataSource"
              :allow-column-resizing="true"
              @cell-prepared="onCellPrepared"
              :initialized="onInitialized"
              :show-borders="true"
              :show-column-lines="true"
              column-resizing-mode="widget"
              :column-auto-width="true"
              :remote-operations="false"
              :row-alternation-enabled="true"
              :column-hiding-enabled="false"
            >
              
                <DxColumn
                data-field="FEATID"
                :fixed="true"
                fixed-position="left"
                :allow-fixing="false"
                data-type="string"
                :width="90"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="SECTOR"
                :fixed="true"
                fixed-position="left"
                :allow-fixing="false"
                data-type="string"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="ESTATE"
                :fixed="true"
                fixed-position="left"
                :allow-fixing="false"
                data-type="string"
                :width="70"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="COMPNO"
                :fixed="true"
                fixed-position="left"
                :allow-fixing="false"
                data-type="string"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="TOT_HA"
                :fixed="true"
                fixed-position="left"
                :allow-fixing="false"
                data-type="number"
                format="#,####0.## Ha"             
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="EST_DATE"
                
                data-type="date"
                format="dd/MM/yyyy"
                fixed-position="left"
                :allow-fixing="false"
                header-cell-template="template-header"
                
              />
              <DxColumn
                data-field="SPECIESID"                
                fixed-position="left"
                :allow-fixing="false"
                data-type="string"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="WODate_LC"                
                fixed-position="left"
                :allow-fixing="false"
                 data-type="date"
                format="dd/MM/yyyy"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="JCOC_LC"              
                fixed-position="center"
                :allow-fixing="false"
                data-type="string"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="WOArea_LC"                           
                :allow-fixing="false"
                data-type="number"
                format="#,####0.## Ha"    
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="ValLC_Date"              
                fixed-position="left"
                :allow-fixing="false"
                 data-type="date"
                format="dd/MM/yyyy"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="ValLC_Area"               
                fixed-position="left"
                :allow-fixing="false"
                data-type="number"
               format="#,####0.## Ha"   
                header-cell-template="template-header"
              />

              <DxColumn
                data-field="WODate_Plt"               
                fixed-position="left"
                :allow-fixing="false"
                 data-type="date"
                format="dd/MM/yyyy"
                header-cell-template="template-header"
              />

              <DxColumn
                data-field="JCOC_Plt"              
                fixed-position="left"
                :allow-fixing="false"
                data-type="string"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="WOArea_Plt"             
                fixed-position="left"
                :allow-fixing="false"
                data-type="number"
                format="#,####0.## Ha"  
                header-cell-template="template-header"
              />
               <DxColumn
                data-field="ValPlt_Date"
                
                fixed-position="left"
                :allow-fixing="false"
                 data-type="date"
                format="dd/MM/yyyy"
                header-cell-template="template-header"
              />
               <DxColumn
                data-field="ValPlt_Area"
                
                fixed-position="left"
                :allow-fixing="false"
                data-type="number"
                format="#,####0.## Ha"  
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="VarCompreg_ValPlt"
                
                fixed-position="left"
                :allow-fixing="false"
                data-type="number"
                format="#,####0.## Ha"  
                header-cell-template="template-header"
              />

              
              
             
              <DxExport :enabled="true" />
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

            </DxDataGrid>
          </div>
        </div>
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
import moment from 'moment';
import CrudService from '../services/crud.service';

import globalConfig from '../config/GlobalConfig.vue';
import { DxForm, DxButtonItem } from 'devextreme-vue/form';
const dataGridRef = 'data-grid';
export default {
  components: {
    DxDataGrid,
    DxColumn,
    DxPaging,
    DxPager,
    DxForm,

    DxButtonItem,
    DxSearchPanel,
    DxExport,
    DxColumnChooser,
    DxColumnFixing,
    DxHeaderFilter,
    DxFilterRow,

  },
  props: ['data', 'flash'],

  data() {
    var toDay = new Date();
    var firstDay = new Date(toDay.getFullYear(), toDay.getMonth (), 1);
    const period = { StartDate: firstDay, EndDate: toDay};
    return {
      period,
      dataSource: new CustomStore({
        key: 'FEATID',
        load: function () {
          var startDate = moment(period.StartDate).format('yyyy-MM-DD');
          var endDate = moment(period.EndDate).format('yyyy-MM-DD');
          return CrudService.findData('monitoring', {
            startDate: startDate,
            endDate: endDate,
          }).then();
        },
      }),
      dataGridRef,
      buttonOptions: {
        text: 'Refresh',
        type: 'success',
        useSubmitBehavior: true,
      },
    };
  },
  methods: {
    validateForm(e) {
      e.component.validate();
    },
    Download(data) {
      window.open(globalConfig.backendBASEURL + data, '_blank');
    },
    downloadfile(e) {
      window.open(globalConfig.backendBASEURL + e.value, '_blank');
    },
    onExporting(e) {
      const workbook = new ExcelJS.Workbook();
      const worksheet = workbook.addWorksheet('monitoring');

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
      this.DataGrid.refresh();
    },
    onInitialized(e) {
      this.DataGrid = e.components;
    },
    handleSubmit(e) {
      this.DataGrid.refresh();
      e.preventDefault();
    },
  },
  computed: {
    DataGrid: function () {
      return this.$refs[dataGridRef].instance;
    },
  },
};
</script>
