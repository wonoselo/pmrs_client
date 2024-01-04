<template>
  <div class="py-12">
    <panel title="Row Data CPR Tracking">
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
                <DxSimpleItem
                  data-field="StartDate"
                  :editor-options="{
                    type: 'date',
                    displayFormat: 'dd/MM/yyyy',
                  }"
                  editor-type="dxDateBox"
                />
                <DxSimpleItem
                  data-field="EndDate"
                  editor-type="dxDateBox"
                  :editor-options="{
                    type: 'date',
                    displayFormat: 'dd/MM/yyyy',
                  }"
                />
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
                data-field="SECTOR"
                :fixed="true"
                fixed-position="left"
                :allow-fixing="false"
                data-type="string"
                caption="Sect"
                :width="60"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="ESTATE"
                :fixed="true"
                fixed-position="left"
                :allow-fixing="false"
                :width="50"
                caption="Est"
                data-type="string"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="FEATNO"
                :fixed="true"
                fixed-position="left"
                :allow-fixing="false"
                data-type="string"
                caption="FeatNo"
                :width="70"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="WO_NUMBER"
                :fixed="true"
                fixed-position="left"
                :allow-fixing="false"
                data-type="string"
                :width="100"
                caption="WO Number"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="JCOC"
                :fixed="true"
                fixed-position="left"
                :allow-fixing="false"
                :width="65"
                data-type="string"
                header-cell-template="template-header"
                caption="JC/OC"
              />
              <DxColumn
                data-field="DAYS_FROM_CPR"
                :fixed="true"
                fixed-position="left"
                :allow-fixing="false"
                :width="125"
                data-type="string"
                header-cell-template="template-header"
                caption="DAYS FROM CPR"
              />
              <DxColumn
                data-field="JCOC_DESC"
                data-type="string"
                :width="150"
                header-cell-template="template-header"
                caption="JC/OC Desc"
              />
              <DxColumn
                data-field="REQ_DATE"
                data-type="date"
                format="dd/MM/yyyy"
                :width="85"
                header-cell-template="template-header"
                caption="CPR Date"
              />
              <DxColumn
                data-field="REQ_SIZE"
                data-type="number"
                :width="80"
                header-cell-template="template-header"
                caption="CPR Size"
              />
              <DxColumn
                data-field="GPS_Upload_Date"
                data-type="date"
                format="dd/MM/yyyy"
                :width="95"
                header-cell-template="template-header"
                caption="GPS Upload"
              />
              <DxColumn
                data-field="GPS_Upload_Name"
                data-type="string"
                :width="115"
                header-cell-template="template-header"
                caption="GPS Upload By"
              />
              <DxColumn
                data-field="CPR_TO_UPLOAD"
                data-type="string"
                :width="125"
                header-cell-template="template-header"
                caption="CPR to UPLOAD"
              />
              <DxColumn
                data-field="Status_GPS"
                data-type="string"
                :width="125"
                header-cell-template="template-header"
                caption="Status GPS"
              />
              <DxColumn
                data-field="GPS_Verified_Name"
                data-type="string"
                :width="115"
                header-cell-template="template-header"
                caption="GPS Verify By"
              />
              <DxColumn
                data-field="UploadStatus"
                data-type="string"
                :width="100"
                cell-template="status-cell-template"
                header-cell-template="template-header"
                caption="Doc Status"
              />
              <DxColumn
                data-field="FinalMapDate"
                data-type="date"
                format="dd/MM/yyyy"
                :width="115"
                header-cell-template="template-header"
                caption="FinalMap Date"
              />
              <DxColumn
                data-field="MapUploadName"
                data-type="string"
                :width="135"
                header-cell-template="template-header"
                caption="Peta Val Upload By"
              />
              <DxColumn
                data-field="GPS_TO_VALIDASI"
                data-type="string"
                :width="125"
                header-cell-template="template-header"
                caption="GPS to Validasi"
              />
              <DxColumn
                data-field="Status_VALIDASI"
                data-type="string"
                :width="110"
                header-cell-template="template-header"
                caption="Status Validasi"
              />
              <DxColumn
                data-field="MapVerifiedName"
                data-type="string"
                :width="140"
                header-cell-template="template-header"
                caption="Peta Val Verified By"
              />
              <DxColumn
                data-field="FinalMapStatus"
                data-type="string"
                :width="120"
                cell-template="status-cell-template"
                header-cell-template="template-header"
                caption="FinalMap Status"
              />
              <DxColumn
                data-field="GIS_UPDATE"
                data-type="string"
                :width="95"
                header-cell-template="template-header"
                caption="GIS Update"
              />
              <DxColumn
                data-field="GISMAP_DATE"
                data-type="date"
                format="dd/MM/yyyy"
                :width="100"
                header-cell-template="template-header"
                caption="GIS Val Date"
              />
              <DxColumn
                data-field="QS_VALID"
                data-type="string"
                :width="80"
                header-cell-template="template-header"
                caption="QS Valid"
              />
              <DxColumn
                data-field="QS_DATE"
                data-type="date"
                format="dd/MM/yyyy"
                :width="80"
                header-cell-template="template-header"
                caption="QS Date"
              />
              <DxColumn
                data-field="QC_VALID"
                data-type="string"
                :width="80"
                header-cell-template="template-header"
                caption="QC Valid"
              />
              <DxColumn
                data-field="QC_DATE"
                data-type="date"
                format="dd/mm/yyyy"
                :width="80"
                header-cell-template="template-header"
                caption="QC Date"
              />
              <DxColumn
                data-field="ROTATION_HIST"
                data-type="string"
                :width="80"
                header-cell-template="template-header"
                caption="ROT Hist"
              />
              <DxColumn
                data-field="CONT_NAME"
                data-type="string"
                :width="125"
                header-cell-template="template-header"
                caption="Contractor"
              />
              <DxColumn
                data-field="FileJoinCheck"
                :width="130"
                caption="Form Join Check"
                data-type="string"
                cell-template="talyTemplate"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="TalySheet"
                :width="90"
                data-type="string"
                cell-template="talyTemplate"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="ShapeFile"
                :width="90"
                caption="Shape File"
                data-type="string"
                cell-template="talyTemplate"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="FileBAP"
                :width="90"
                caption="Peta Kerja"
                data-type="string"
                cell-template="talyTemplate"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="FotoUdara"
                data-type="string"
                caption="Foto Udara"
                :width="125"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="FinalMapFile"
                :width="120"
                caption="Peta Validasi"
                data-type="string"
                cell-template="talyTemplate"
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
              <template #talyTemplate="{ data: cellData }">
                <DxButton
                  :cell-data="cellData"
                  hint="Download File"
                  styling-mode="outlined"
                  icon="download"
                  type="default"
                  @click="downloadfile(cellData)"
                  v-if="cellData.value"
                />
              </template>
              <template #status-cell-template="{ data }">
                <div>
                  <div class="badge badge-success" v-if="data.value == 3">
                    Verified
                  </div>
                  <div class="badge badge-info" v-else-if="data.value == 2">
                    Waiting Verification
                  </div>
                  <div class="badge badge-warning" v-else-if="data.value == 1">
                    Need Reupload
                  </div>
                  <div class="badge badge-default" v-else>Not Yet Upload</div>
                </div>
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
import DxButton from 'devextreme-vue/button';
import globalConfig from '../config/GlobalConfig.vue';
import { DxForm, DxSimpleItem, DxButtonItem } from 'devextreme-vue/form';
const dataGridRef = 'data-grid';
export default {
  components: {
    DxDataGrid,
    DxColumn,
    DxPaging,
    DxPager,
    DxForm,
    DxSimpleItem,
    DxButtonItem,
    DxSearchPanel,
    DxExport,
    DxColumnChooser,
    DxColumnFixing,
    DxHeaderFilter,
    DxFilterRow,
    DxButton,
  },
  props: ['data', 'flash'],

  data() {
    var toDay = new Date();
    var firstDay = new Date(toDay.getFullYear(), toDay.getMonth(), 1);
    const period = { StartDate: firstDay, EndDate: toDay };
    return {
      period,
      dataSource: new CustomStore({
        key: 'ID',
        load: function () {
          var startDate = moment(period.StartDate).format('YYYY-MM-DD');
          var endDate = moment(period.EndDate).format('YYYY-MM-DD');
          return CrudService.findData('tracking', {
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
      const worksheet = workbook.addWorksheet('Tracking');

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
    onCellPrepared(e) {
      if (e.rowType == 'data' && e.column.dataField == 'Status_GPS')
        {
          if (e.data.Status_GPS == 'Ontime') {
            e.cellElement.style.color = "blue";
          }
          else if (e.data.Status_GPS == 'Late') {
            e.cellElement.style.color = "red";
          }
          else {
            e.cellElement.style.color = "black"; 
          }
        }
      
      if (e.rowType == 'data' && e.column.dataField == 'Status_VALIDASI')
        {
          if (e.data.Status_VALIDASI == 'Ontime') {
            e.cellElement.style.color = "blue";
          }
          else if (e.data.Status_VALIDASI == 'Late') {
            e.cellElement.style.color = "red";
          }
          else {
            e.cellElement.style.color = "black"; 
          }
        }

      if (e.rowType == 'data' && e.column.dataField == 'DAYS_FROM_CPR')
        {
          if (e.data.DAYS_FROM_CPR <= 5) {
            e.cellElement.style.color = "blue";
          }
          else if (e.data.DAYS_FROM_CPR >= 5) {
            e.cellElement.style.color = "red";
          }
            
        }
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
