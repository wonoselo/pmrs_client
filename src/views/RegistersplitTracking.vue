<template>
  <div class="py-12">
    <panel title="Data Register/Split Tracking">
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
                data-field="Sector"
                :fixed="true"
                fixed-position="left"
                :allow-fixing="false"
                data-type="string"
                :width="65"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Featno"
                :fixed="true"
                fixed-position="left"
                :calculate-cell-value="calculateCellValue"
                :allow-fixing="false"
                data-type="string"
                caption="Compt Lama"
                :width="120"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Kategori"
                :fixed="true"
                fixed-position="left"
                :allow-fixing="false"
                data-type="string"
                :width="80"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Sitetype"
                data-type="string"
                :fixed="true"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Landcover"
                data-type="string"
                :fixed="true"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Replant"
                data-type="string"
                :fixed="true"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Jenisbelukar"
                data-type="string"
                :fixed="true"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Featno_Baru"
                :fixed="true"
                fixed-position="left"
                :allow-fixing="false"
                data-type="string"
                caption="Compt Baru"
                :width="120"
                header-cell-template="template-header"
              />
               <DxColumn
                data-field="SPECIESID"
                data-type="string"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Statusrequest"
                data-type="string"

                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Uploadreg_Remarks"
                data-type="string"
                :width="125"
                caption="Remarks"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Uploadreg_Reupload_Remarks"
                data-type="string"
                :width="125"
                caption="Reupload Remarks"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Uploadreg_UploadStatus"
                data-type="string"
                cell-template="status-cell-template"
                header-cell-template="template-header"
                caption="Doc Status"
              />
              <DxColumn
                data-field="Uploadby_name"
                data-type="string"
                caption="UploadBy"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Verifiedby_name"
                data-type="string"
                caption="VerifiedBy"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Uploadreg_Upload_Date"
                data-type="date"
                format="dd/MM/yyyy"
                caption="Upload Date"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Berita_Acara"
                data-type="string"
                caption="BA/Form PCCR"
                cell-template="DownloadTemplate"
                header-cell-template="template-header"
                  />
              <DxColumn
                data-field="Shapefile"
                data-type="string"
                cell-template="DownloadTemplate"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Lampiran_petabefore"
                data-type="string"
                caption="Lampiran Peta Sebelum"
                cell-template="DownloadTemplate"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Lampiran_petaafter"
                data-type="string"
                caption="Lampiran Peta Sesudah"
                cell-template="DownloadTemplate"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Final_Remarks"
                data-type="string"
                caption="Final Remarks"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Final_Reupload_Remarks"
                data-type="string"
                caption="Final Reupload Remarks"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Final_UploadStatus"
                data-type="string"
                cell-template="status-cell-template"
                header-cell-template="template-header"
                caption="Final Doc Status"
              />
              <DxColumn
                data-field="UploadBy_namefinal"
                data-type="string"
                caption="Final UploadBy"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="VerifiedBy_namefinal"
                data-type="string"
                caption="Final VerifiedBy"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Final_Upload_Date"
                data-type="date"
                format="dd/MM/yyyy"
                caption="Final Upload Date"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Lampiran_petabaru"
                data-type="string"
                caption="Lampiran Peta Baru"
                cell-template="DownloadTemplate"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Lampiran_finalpccr"
                data-type="string"
                caption="Lampiran Final PCCR"
                cell-template="DownloadTemplate"
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
              <template #DownloadTemplate="{ data: cellData }">
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
        key: 'id',
        load: function () {
          var startDate = moment(period.StartDate).format('YYYY-MM-DD');
          var endDate = moment(period.EndDate).format('YYYY-MM-DD');
          return CrudService.findData('registersplittracking', {
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
    calculateCellValue(rowData) {
      return rowData.Estate + rowData.Featno;
    },
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
      const worksheet = workbook.addWorksheet('Registersplittracking');

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
