<template>
  <div class="py-12">
    <panel title="Payment">
      <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
        <DxDataGrid
          :data-source="dataSource"
          @editing-start="onEditingStart"
          @cell-prepared="onCellPrepared"
          @toolbar-preparing="onToolbarPreparing($event)"
          :allow-column-resizing="true"
          @initialized="onInitialized"
          :show-borders="true"
          column-resizing-mode="widget"
          :column-auto-width="true"
          :show-column-lines="true"
          :remote-operations="false"
          :row-alternation-enabled="true"
          :column-hiding-enabled="false"
        >
          <!-- form Edit -->
          <DxEditing
            :allow-updating="Access.AllowEdit"
            :allow-adding="false"
            :allow-deleting="false"
            :allow-view="false"
            :use-icons="true"
            mode="popup"
          >
            <DxPopup 
            :width="850" 
            :show-title="true" 
            title="Form Upload">
              <DxPosition my="center" at="center" of="window" />
            </DxPopup>
            <DxForm :col-count="1" :show-colon-after-label="false">
             
              <!-- Upload 1 -->
              <DxGroupItem caption="Bukti Pembayaran">
                <DxSimpleItem
                  data-field="UploadPembayaran"
                  :label="{ text: ' ' }"
                />
              </DxGroupItem>
              
              <!-- Upload 2 -->
              <DxItem
                :editor-options="{
                  value: '',
                  searchEnabled: true,
                  items: positions,
                }"
                :validation-rules="validationRules.position"
                data-field="JenisPembayaran"
                editor-type="dxSelectBox"
              />
              <DxItem
                data-field="Nominal"                            
                :editor-options="{
                  format:'Rp #,##0.##',
                  showClearButton: true
                }"
                :validation-rules="validationRules.position"
              />
              
              <DxItem data-field="Remarks" editor-type="dxTextArea" />
            </DxForm>
          </DxEditing>
          <!--End form Edit -->
          <DxColumn
            type="buttons"
            :width="50"
            :fixed="true"
            caption="Upload"
            :visible="Access.AllowEdit"
            fixed-position="left"
            header-cell-template="template-header"
            :allow-fixing="false"
            :use-icons="true"
          />
          <DxColumn
            :width="50"
            :allow-grouping="false"
            :allow-filtering="false"
            :allow-editing="false"
            :fixed="true"
            fixed-position="left"
            :allow-fixing="false"
            data-field="id"
            caption="Action"
            header-cell-template="template-header"
            cell-template="verifybuktiTemplate"
          />
          <DxColumn
            data-field="Sector"
            :fixed="true"
            fixed-position="left"
            :allow-fixing="false"
            data-type="string"
            caption="Sector"
            :width="70"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Estate"
            :fixed="true"
            fixed-position="left"
            :allow-fixing="false"
            :width="70"
            caption="Estate"
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
            data-type="string"
            caption="Pola"
            :fixed="true"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Nama_Claimer"
            data-type="string"
            caption="Nama Claimer"
            :fixed="true"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="No_KTP_Claimer"
            data-type="string"
            :fixed="true"
            caption="No KTP Claimer"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Luas"
            data-type="string"
            caption="Luas(Ha)"
            :fixed="true"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Status_Payment_Time"
            data-type="string"
            caption="Status Payment Time"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="resttime_payment"
            data-type="string"
            caption="Deadline"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="UploadStatus_Sslho"
            data-type="string"
            caption="Doc Status"
            cell-template="status-cell-template"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Remarks"
            data-type="string"
            caption="Remarks"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="ReuploadRemarks"
            data-type="string"
            caption="Reupload Remarks"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Sslho_Upload_Date"
            data-type="date"
            format="dd/MM/yyyy"
            caption="Upload Date"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="SslhoUpload_name"
            data-type="string"
            caption="Upload By"
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
            data-field="ShapeFile"
            caption="Shape File"
            data-type="string"
            cell-template="DownloadTemplate"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="BeritaAcara"
            data-type="string"
            caption="Berita Acara"
            cell-template="DownloadTemplate"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Peta_verify_sementara"
            data-type="string"
            cell-template="DownloadTemplate"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Peta_final"
            data-type="string"
            caption="Peta final"
            cell-template="DownloadTemplate"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Doc_Advance"
            data-type="string"
            caption="File Document"
            cell-template="DownloadTemplate"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="JenisPembayaran"
            data-type="number"
            caption="Jenis Pembayaran"
            header-cell-template="template-header"
          />
          <DxColumn
            caption="Nominal Pembayaran"
            data-field="Nominal"
            data-type="number"
            format="Rp #,##0.##"                          
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="UploadPembayaran"
            data-type="string"
            caption="Bukti Pembayaran"
            cell-template="DownloadTemplate"
            edit-cell-template="editBuktiTemplate"
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

           <!-- Template Icon Download -->
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

          <!-- TEMPLATE UPLOAD PF -->
          <template #editBuktiTemplate="{ data }">
            <div>
              <span v-if="fileBukti"
                >Current file : <b>{{ fileBukti[4] }}</b></span
              ><br />
              <DxButton
                :cell-data="data"
                hint="Download File"
                styling-mode="outlined"
                icon="download"
                type="default"
                @click="downloadfile(data)"
                v-if="fileBukti"
              />
              <DxButton
                :cell-data="data"
                hint="Delete File"
                styling-mode="outlined"
                icon="remove"
                type="default"
                @click="deleteFile(data)"
                v-if="fileBukti"
              />
              <DxFileUploader
                :multiple="true"
                accept="image/png,application/pdf,image/jpeg"
                upload-mode="instantly"
                :upload-url="uploadBukti"
                :upload-headers="header"
                :max-file-size="5242880"
                @value-changed="onBuktiValueChanged"
                @uploaded="(e) => onUploaded(e, data)"
              />
            </div>
          </template>
          <!-- END TEMPLATE UPLOAD PF -->

          <template #status-cell-template="{ data }">
            <div>
              <div class="badge badge-primary" v-if="data.value == 2">
                Waiting Verification
              </div>
              <div class="badge badge-warning" v-else-if="data.value == 1">
                Need Reupload
              </div>
              <div class="badge badge-default" v-else>Not Yet Upload</div>
            </div>
          </template>
          <template #verifybuktiTemplate="{ data: cellData }">
            <div>
              <DxButton
                :cell-data="cellData"
                :visible="
                  (cellData.data.UploadStatus_Sslho === '2' ||
                    cellData.data.UploadStatus_Sslho === 2) &&
                  VAccess.AllowEdit
                "
                hint="Verify Documents"
                styling-mode="outlined"
                icon="check"
                type="default"
                @click="verifyIconClick(cellData)"
              />
            </div>
          </template>
        </DxDataGrid>
      </div>
    </panel>
    <MyPopup
      :visible="popupVisible"
      :drag-enabled="false"
      :close-on-outside-click="false"
      :show-close-button="false"
      :show-title="true"
      :width="400"
      :height="600"
      :shading="true"
      container=".dx-viewport"
      title="Chose Action"
    >
      <MyPosition at="center" my="center" of="window" />
      <MyToolbar
        widget="dxButton"
        toolbar="bottom"
        location="before"
        :options="verifyOptions"
      />
      <MyToolbar
        widget="dxButton"
        toolbar="bottom"
        location="before"
        :options="reupOptions"
      />
      <MyToolbar
        widget="dxButton"
        toolbar="bottom"
        location="after"
        :options="closeOptions"
      />
      <div>
        <div class="form">
          <div class="dx-fieldset">
            <div class="dx-fieldset-header">Bukti Pembayaran (image / pdf)</div>
            <div v-if="fileBukti">
              File Name : <b>{{ fileBukti[4] }}</b>
            </div>
            <div v-else>File not uploaded</div>
            <DxButton
              hint="Download Peta_verify_sementara"
              styling-mode="outlined"
              icon="download"
              type="default"
              @click="Download(DataBukti.UploadPembayaran)"
              v-if="fileBukti"
            />
          </div>
          <div class="dx-fieldset">
            <div class="dx-fieldset-header">Jenis Pembayaran</div>
            <DxTextArea
              :height="90"
              :read-only="true"
              :value="DataBukti.JenisPembayaran"
            />
          </div>
           <div class="dx-fieldset">
            <div class="dx-fieldset-header">Nominal Pembayaran</div>
            <DxTextArea
              :height="90"
              :read-only="true"
              :value="DataBukti.Nominal"
            />
          </div>
          <div class="dx-fieldset">
            <div class="dx-fieldset-header">Remarks</div>
            <DxTextArea
              :height="90"
              :read-only="true"
              :value="DataBukti.Remarks"
            />
          </div>
        </div>
      </div>
    </MyPopup>
  </div>
</template>
<script>
import DxFileUploader from 'devextreme-vue/file-uploader';
import { DxTextArea } from 'devextreme-vue/text-area';
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
  DxColumnChooser,
  DxColumnFixing,
  DxHeaderFilter,
  DxFilterRow,
} from 'devextreme-vue/data-grid';
import CustomStore from 'devextreme/data/custom_store';
import { exportDataGrid } from 'devextreme/excel_exporter';
import ExcelJS from 'exceljs';
import saveAs from 'file-saver';
import Swal from 'sweetalert2';
import { DxSimpleItem, DxGroupItem, DxItem } from 'devextreme-vue/form';
import CrudService from '../services/crud.service';
import LocalStorageService from '../LocalStorageService';
import DxButton from 'devextreme-vue/button';
import globalConfig from '../config/GlobalConfig.vue';
import { alert, confirm } from 'devextreme/ui/dialog';

const localStorageService = LocalStorageService.getService();
const dataGridRef = 'data-grid';
const positions = ['Bayar', 'MoU'];
import {
  DxPopup as MyPopup,
  DxPosition as MyPosition,
  DxToolbarItem as MyToolbar,
} from 'devextreme-vue/popup';
export default {
  components: {
    MyPopup,
    DxItem,
    MyPosition,
    MyToolbar,
    DxFileUploader,
    DxTextArea,
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
    DxSimpleItem,
    DxGroupItem,
    DxColumnChooser,
    DxColumnFixing,
    DxHeaderFilter,
    DxFilterRow,
    DxButton,
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
    const uploadBukti = globalConfig.backendAPIURL + 'sslho/BuktiPembayaran/';
    const fileBukti = '';
    const popupVisible = false;
    const DataBukti = {};
    const fileAdded = false;
    const Grid = {};
    const store = new CustomStore({
      key: 'id',
      load: function () {
        return CrudService.getAll('sslho/index');
      },
      update: (key, values) => 
      {
        if (this.fileAdded) {
          alert(
            'Update Failed, Please finish all your upload before you can save the data',
            'Error'
          );
          return false;
        } else {
          return CrudService.updateData('sslho/update', key, values);
        }
      },
    });

    return {
      dataSource: store,
      positions,
      dataGridRef,
      Access,
      VAccess,
      header,
      uploadBukti,
      fileBukti,
      DataBukti,
      popupVisible,
      Grid,
      fileAdded,
      validationRules: {
        position: [{ type: 'required', message: 'Required.' }],
      },
      verifyOptions: {
        icon: 'check',
        type: 'success',
        text: 'Verify Document',
        onClick: () => {
          let result = confirm(
            '<i>Are you sure to verify?</i>',
            'Confirm changes'
          );
          result.then((dialogResult) => {
            if (dialogResult) {
              this.popupVisible = false;
              return CrudService.updateData('verifysslho', this.DataBukti.id, {
                action: 'verify',
              }).then(() => {
                this.Grid.refresh();
              });
            }
          });
        },
      },
      reupOptions: {
        icon: 'edit',
        type: 'danger',
        text: 'Edit',
        onClick: () => {
          let result = confirm(
            '<i>Are you sure to ask for editing?</i>',
            'Confirm changes'
          );
          result.then((dialogResult) => {
            if (dialogResult) {
              this.popupVisible = false;
              Swal.fire({
                title: 'Please add reason for editing',
                input: 'text',
                inputAttributes: {
                  autocapitalize: 'off',
                },
                showCancelButton: true,
                confirmButtonText: 'Submit',
                showLoaderOnConfirm: true,
                preConfirm: (reason) => {
                  return CrudService.updateData('verifysslho', this.DataBukti.id, {
                    action: 'reject',
                    reason: reason,
                  })
                    .then((response) => {
                      if (!response.status == 'success') {
                        throw new Error(response.message);
                      }
                      this.DataGrid.refresh();
                      return response;
                    })
                    .catch((error) => {
                      Swal.showValidationMessage(`Request failed: ${error}`);
                    });
                },
                allowOutsideClick: false,
              }).then((result) => {
                if (result.value) {
                  this.Grid.refresh();
                }
              });
            }
          });
        },
      },
      closeOptions: {
        icon: 'clear',
        type: 'default',
        text: 'Cancel',
        onClick: () => {
          this.popupVisible = false;
        },
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
    verifyIconClick(e) {
      this.DataBukti = e.data;
      this.fileBukti = e.data.UploadPembayaran? e.data.UploadPembayaran.split('/') : '';
      this.popupVisible = true;
    },
    downloadfile(e) {
      window.open(globalConfig.backendBASEURL + e.value, '_blank');
    },
    deleteFile(e) {
      if (e.columnIndex == 18) this.fileBukti = '';
      e.setValue('');
    },
    onExporting(e) {
      const workbook = new ExcelJS.Workbook();
      const worksheet = workbook.addWorksheet('sslho');

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
      this.uploadBukti = globalConfig.backendAPIURL + 'sslho/BuktiPembayaran/' + e.data.id;
      this.fileBukti = e.data.UploadPembayaran ? e.data.UploadPembayaran.split('/') : '';
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
      if (e.column.index == 0 && e.rowType == 'data') {
        if (
          e.data.UploadStatus_Sslho === 3 ||
          e.data.UploadStatus_Sslho === '3' ||
          e.data.UploadStatus_Sslho === '2' ||
          e.data.UploadStatus_Sslho === 2
        ) {
          e.cellElement.innerHTML = '';
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
      this.Grid.refresh();
    },
    onInitialized(e) {
      this.Grid = e.component;
    },
    onBuktiValueChanged(e) {
      this.fileAdded = true;
      e.component.option('uploadUrl', this.uploadBukti);
    },
    onUploaded(e, cellInfo) {
      var data = JSON.parse(e.request.responseText);
      if (data.status == 'success') {
        this.fileAdded = false;
        cellInfo.setValue(data.path);
      } else {
        alert(data.message, 'Error');
      }
    },
  },
  created() {
    CrudService.findData('accessroles/check', { module: 'SslHo' }).then(
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
    CrudService.findData('accessroles/check', {
       /** VerifySSL DIAMBIL DARI MODUL NAME DI APLIKASI */
      module: 'VerifySSL',
    }).then((response) => {
      this.VAccess = response.data;
      if (response.isadmin)
        this.VAccess = {
          AllowView: true,
          AllowAdd: true,
          AllowEdit: true,
          AllowDelete: true,
        };
    });
  },
};
</script>

