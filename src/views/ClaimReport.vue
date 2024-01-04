<template>
  <div class="py-12">
    <panel title="Claim Report">
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
                caption="Sect"
                :width="60"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Estate"
                :fixed="true"
                fixed-position="left"
                :allow-fixing="false"
                caption="Est"
                data-type="string"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Featno"
                :fixed="true"
                fixed-position="left"
                :allow-fixing="false"
                data-type="string"
                caption="FeatNo"
                :width="70"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Pola"
                :fixed="true"
                fixed-position="left"
                :allow-fixing="false"
                data-type="string"
                :width="85"
                caption="Pola"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Nama_Claimer"
                :fixed="true"
                fixed-position="left"
                :allow-fixing="false"
                :width="115"
                data-type="string"
                header-cell-template="template-header"
                caption="Claimer Name"
              />
              <DxColumn
                data-field="No_KTP_Claimer"
                :fixed="true"
                fixed-position="left"
                :allow-fixing="false"
                :width="125"
                data-type="string"
                header-cell-template="template-header"
                caption="No.KTP"
              />
              <DxColumn
                data-field="Luas"
                data-type="number"
                :width="65"
                format="#,####0.## Ha"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Ktp"
                data-type="string"
                caption="KTP"
                cell-template="DownloadTemplate"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Surat_Claim"
                data-type="string"
                caption="Surat Claim"
                cell-template="DownloadTemplate"
                header-cell-template="template-header"
              />

             <DxColumn
                data-field="Req_Upload_Date"
                data-type="date"
                format="dd/MM/yyyy"
                :width="125"
                header-cell-template="template-header"
                caption="Req Upload Date"
              />

               <DxColumn
                data-field="ReqUpload_name"
                data-type="string"
                :width="125"
                header-cell-template="template-header"
                caption="Req Upload By"
              />

              <DxColumn
                data-field="ReqVerified_name"
                data-type="string"
                :width="125"
                header-cell-template="template-header"
                caption="Req Verified By"
              />

               <DxColumn
                data-field="UploadStatus"
                data-type="string"
                :width="115"
                cell-template="status-cell-template" 
                header-cell-template="template-header"
                caption="Status Upload"
              />
              <!-- END REQ SSL -->
              <!-- COL PLANNINGSECTOR -->
              <DxColumn
                data-field="Processing_Time_Plansect"
                data-type="string"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Measurement_Time_Status"
                data-type="string"
                caption="Measurement Time Status"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="ShapeFile" 
                data-type='string'             
                :width="95"
                cell-template="DownloadTemplate"
                header-cell-template="template-header"
                caption="Shape File"
              />
              <DxColumn
                data-field="BeritaAcara"
                data-type="string"
                caption="Berita Acara"
                cell-template="DownloadTemplate"
                edit-cell-template="editBATemplate"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Plansect_Upload_Date"
                 data-type="date"
                format="dd/MM/yyyy"
                :width="130"
                header-cell-template="template-header"
                caption="Plan Upload Date"
              />
              <DxColumn
                data-field="PlanUpload_name"
                data-type="string"
                :width="125"
                header-cell-template="template-header"
                caption="Plan Upload By"
              />
              <DxColumn
                data-field="PlanVerified_name"
                data-type="string"
                :width="125"
                header-cell-template="template-header"
                caption="Plan Verified By"
              />
              <DxColumn
                data-field="UploadStatusPlan"
                data-type="string"
                :width="165"
                cell-template="status-cell-template"
                header-cell-template="template-header"
                caption="Planning Upload Status"
              />
              <!-- END COL PLANNINGSECTOR -->
              <!-- START COL STATUTORY -->
              <DxColumn
                data-field="Processing_time_statutory"
                data-type="string"
                caption="Processing Time StatutoryHO"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Status_Verification_Time"
                data-type="string"
               
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Peta_verify_sementara"
                data-type="string"
                :width="125"
                cell-template="DownloadTemplate"
                header-cell-template="template-header"
                caption="Peta Sementara"
              />
              <DxColumn
                data-field="Peta_final"
                data-type="string"
                :width="85"
                cell-template="DownloadTemplate"
                header-cell-template="template-header"
                caption="Peta Final"
              />
              <DxColumn
                data-field="Statutory_Upload_Date"
                data-type="date"
                format="dd/MM/yyyy"
                :width="155"
                header-cell-template="template-header"
                caption="Statutory Upload Date"
              />
              <DxColumn
                data-field="StatutoryUpload_name"
                data-type="string"
                :width="155"
                header-cell-template="template-header"
                caption="Statutory Upload By"
              />
              <DxColumn
                data-field="StatutoryVerified_name"
                data-type="string"
                :width="155"
                header-cell-template="template-header"
                caption="Statutory Verified By"
              />
              <DxColumn
                data-field="Statutory_UploadStatus"
                data-type="string"
                :width="165"
                cell-template="status-cell-template"
                header-cell-template="template-header"
                caption="Statutory Upload Status"
              />
              <DxColumn
                data-field="RemarksStatutory"
                data-type="string"
                :width="165"
                
                header-cell-template="template-header"
                caption="Remarks Statutory"
              />

              <!-- END STATUTORY -->
              <!-- START COL SUBMISSION -->
              <DxColumn
                data-field="Processing_Time_Submission"
                data-type="string"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Status_Submission_Time"
                data-type="string"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Doc_Advance"
                data-type="string"
                :width="115"
                cell-template="DownloadTemplate"
                header-cell-template="template-header"
                caption="File Advance"
              />
              <DxColumn
                data-field="Submission_Upload_Date"
                data-type="date"
                format="dd/MM/yyyy"
                :width="175"
                header-cell-template="template-header"
                caption="Submission Upload Date"
              />
              <DxColumn
                data-field="SubmissionUpload_name"
                data-type="string"
                :width="155"
                header-cell-template="template-header"
                caption="Submission Upload By"
              />
               <DxColumn
                data-field="SubmissionVerified_name"
                data-type="string"
                :width="160"
                header-cell-template="template-header"
                caption="Submission Verified By"
              />
              <DxColumn
                data-field="UploadStatus_Submission"
                data-type="string"
                :width="175"
                cell-template="status-cell-template"
                header-cell-template="template-header"
                caption="Submission Upload Status"
              />
              <!-- END SUBMISSION -->
              <!-- START COL SSLHO -->
              <DxColumn
                data-field="Processing_Time_Payment"
                data-type="string"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Status_Payment_Time"
                data-type="string"
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="UploadPembayaran"
                data-type="string"
                :width="145"
                cell-template="DownloadTemplate"
                header-cell-template="template-header"
                caption="Upload Pembayaran"
              />
              <DxColumn
                data-field="JenisPembayaran"
                data-type="string"
                :width="130"
                header-cell-template="template-header"
                caption="Jenis Pembayaran"
              />
              <DxColumn
                caption="Nominal Pembayaran"
                data-field="Nominal"
                data-type="number"
                format="Rp #,##0.##"                          
                header-cell-template="template-header"
              />
              <DxColumn
                data-field="Sslho_Upload_Date"
                data-type="date"
                format="dd/MM/yyyy"
                :width="135"
                header-cell-template="template-header"
                caption="Sslho Upload Date"
              />
              <DxColumn
                data-field="SslhoUpload_name"
                data-type="string"
                :width="125"
                header-cell-template="template-header"
                caption="Sslho Upload By"
              />
               <DxColumn
                data-field="SslhoVerified_name"
                data-type="string"
                :width="130"
                header-cell-template="template-header"
                caption="Sslho Verified By"
              />
              <DxColumn
                data-field="UploadStatus_Sslho"
                data-type="string"
                :width="145"
                cell-template="status-cell-template"
                header-cell-template="template-header"
                caption="Sslho Upload Status"
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
                  <div class="badge badge-success" v-if="data.value == 3" >
                    Verified
                  </div>
                  <div class="badge badge-primary" v-else-if="data.value == 2">
                    Waiting Verification
                  </div>
                  <div class="badge badge-warning" v-else-if="data.value == 1">
                    Need Reupload
                  </div>
                  <div class="badge badge-default" v-else>Not Yet Upload</div>
                </div>
              </template>
            </DxDataGrid><br>
            <!-- Footer Status -->
            <div style="color:black; float: right; font-size: 10px;">
              <b><i>Note Status :</i></b><br>
              <div style="font-size: 10px;">
                 1 = Need Reupload <br>
                2 = Waiting Verification <br>
                3 = Verified
              </div>  
            </div>
            <!-- End Footer Status -->
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
    var firstDay = new Date(toDay.getFullYear(), toDay.getMonth (), 1);
    const period = { StartDate: firstDay, EndDate: toDay};
    return {
      period,
      dataSource: new CustomStore({
        key: 'id',
        load: function () {
          var startDate = moment(period.StartDate).format('yyyy-MM-DD');
          var endDate = moment(period.EndDate).format('yyyy-MM-DD');
          return CrudService.findData('claimreport', {
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
      const worksheet = workbook.addWorksheet('claimreport');

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
      if (e.rowType == 'data' && e.column.dataField == 'Measurement_Time_Status')
          {
            if (e.data.Measurement_Time_Status == 'Ontime') {
              e.cellElement.style.color = "blue";
            }
            else if (e.data.Measurement_Time_Status == 'Late') {
              e.cellElement.style.color = "red";
            }
            else {
              e.cellElement.style.color = "black"; 
            }
          }

      if (e.rowType == 'data' && e.column.dataField == 'Status_Verification_Time')
        {
          if (e.data.Status_Verification_Time == 'Ontime') {
            e.cellElement.style.color = "blue";
          }
          else if (e.data.Status_Verification_Time == 'Late') {
            e.cellElement.style.color = "red";
          }
          else {
            e.cellElement.style.color = "black"; 
          }
        }
      
      if (e.rowType == 'data' && e.column.dataField == 'Status_Submission_Time')
        {
          if (e.data.Status_Submission_Time == 'Ontime') {
            e.cellElement.style.color = "blue";
          }
          else if (e.data.Status_Submission_Time == 'Late') {
            e.cellElement.style.color = "red";
          }
          else {
            e.cellElement.style.color = "black"; 
          }
        }
        
      if (e.rowType == 'data' && e.column.dataField == 'Status_Payment_Time')
        {
          if (e.data.Status_Payment_Time == 'Ontime') {
            e.cellElement.style.color = "blue";
          }
          else if (e.data.Status_Payment_Time == 'Late') {
            e.cellElement.style.color = "red";
          }
          else {
            e.cellElement.style.color = "black"; 
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
