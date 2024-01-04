<template>
  <div class="py-12">
    <panel title="Document Verification">
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
            <DxPopup :width="850" :show-title="true" title="Form Upload">
              <DxPosition my="center" at="center" of="window" />
            </DxPopup>
            <DxForm :col-count="1" :show-colon-after-label="false">
              <!-- Upload 1 -->
              <DxGroupItem caption="Peta Verify Sementara"><DxSimpleItem data-field="Peta_verify_sementara" :label="{ text: ' ' }"/></DxGroupItem>
              <!-- Upload 2 -->
              <DxGroupItem caption="Peta Final"><DxSimpleItem data-field="Peta_final" :label="{ text: ' ' }" /></DxGroupItem>
              <DxGroupItem caption="Remarks"><DxSimpleItem :editor-options="{ height: 100 }" editor-type="dxTextArea" data-field="Remarks" :label="{ text: ' ' }"/></DxGroupItem>
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
            cell-template="verifystatutoryTemplate"
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
            data-field="Status_Verification_Time"
            data-type="string"
            caption="Status Verification Time"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="resttime_statutory"
            data-type="string"
            caption="Deadline"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Statutory_UploadStatus"
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
            data-field="Statutory_Upload_Date"
            data-type="date"
            format="dd/MM/yyyy"
            caption="Upload Date"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="StatutoryUpload_name"
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
            caption="Peta Verifikasi Sementara"
            cell-template="DownloadTemplate"
            edit-cell-template="editPVSTemplate"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Peta_final"
            data-type="string"
            caption="Peta final"
            cell-template="DownloadTemplate"
            edit-cell-template="editPFTemplate"
            header-cell-template="template-header"
          />
          

          <DxExport :enabled="true" :allow-export-selected-data="true" />
          <DxColumnChooser :enabled="false" />
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

          <!-- TEMPLATE UPLOAD PVS -->
          <template #editPVSTemplate="{ data }">
            <div>
              <span v-if="filePVS"
                >Current file : <b>{{ filePVS[4] }}</b></span
              ><br />
              <DxButton
                :cell-data="data"
                hint="Download File"
                styling-mode="outlined"
                icon="download"
                type="default"
                @click="downloadfile(data)"
                v-if="filePVS"
              />
              <DxButton
                :cell-data="data"
                hint="Delete File"
                styling-mode="outlined"
                icon="remove"
                type="default"
                @click="deleteFile(data)"
                v-if="filePVS"
              />
              <DxFileUploader
                :multiple="true"
                accept="image/png,application/pdf,image/jpeg"
                upload-mode="instantly"
                :upload-url="uploadPVS"
                :upload-headers="header"
                :max-file-size="5242880"
                @value-changed="onPVSValueChanged"
                @uploaded="(e) => onUploaded(e, data)"
              />
            </div>
          </template>
          <!-- END TEMPLATE UPLOAD PVS -->

          <!-- TEMPLATE UPLOAD PF -->
          <template #editPFTemplate="{ data }">
            <div>
              <span v-if="filePF"
                >Current file : <b>{{ filePF[4] }}</b></span
              ><br />
              <DxButton
                :cell-data="data"
                hint="Download File"
                styling-mode="outlined"
                icon="download"
                type="default"
                @click="downloadfile(data)"
                v-if="filePF"
              />
              <DxButton
                :cell-data="data"
                hint="Delete File"
                styling-mode="outlined"
                icon="remove"
                type="default"
                @click="deleteFile(data)"
                v-if="filePF"
              />
              <DxFileUploader
                :multiple="true"
                accept="image/png,application/pdf,image/jpeg"
                upload-mode="instantly"
                :upload-url="uploadPF"
                :upload-headers="header"
                :max-file-size="5242880"
                @value-changed="onPFValueChanged"
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
          <template #verifystatutoryTemplate="{ data: cellData }">
            <div>
              <DxButton
                :cell-data="cellData"
                :visible="
                  (cellData.data.Statutory_UploadStatus === '2' ||
                    cellData.data.Statutory_UploadStatus === 2) &&
                  VAccess.AllowEdit
                "
                hint="Verify Documents"
                styling-mode="outlined"
                icon="check"
                type="default"
                @click="verifyIconClick(cellData)"
              />
              <DxButton
                :cell-data="cellData"
                :visible="
                  (cellData.data.Statutory_UploadStatus === '1' ||
                    cellData.data.Statutory_UploadStatus === 1) &&
                  VAccess.AllowEdit
                "
                hint="Send Reminder"
                styling-mode="outlined"
                icon="warning"
                type="default"
                @click="reuploadIconClick(cellData)"
              />
              <DxButton
                :cell-data="cellData"
                :visible="
                  (cellData.data.Statutory_UploadStatus === '2' ||
                    cellData.data.Statutory_UploadStatus === 2) &&
                  Access.AllowEdit
                "
                hint="Send Reminder"
                styling-mode="outlined"
                icon="warning"
                type="default"
                @click="remindIconClick(cellData)"
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
            <div class="dx-fieldset-header">Peta Verifikasi Sementara (image / pdf)</div>
            <div v-if="filePVS">
              File Name : <b>{{ filePVS[4] }}</b>
            </div>
            <div v-else>File not uploaded</div>
            <DxButton
              hint="Download Peta_verify_sementara"
              styling-mode="outlined"
              icon="download"
              type="default"
              @click="Download(DataStatutory.Peta_verify_sementara)"
              v-if="filePVS"
            />
          </div>
          <div class="dx-fieldset">
            <div class="dx-fieldset-header">Peta Final (image / pdf)</div>
            <div v-if="filePF">
              File Name : <b>{{ filePF[4] }}</b>
            </div>
            <div v-else>File not uploaded</div>
            <DxButton
              hint="Download Peta_final"
              styling-mode="outlined"
              icon="download"
              type="default"
              @click="Download(DataStatutory.Peta_final)"
              v-if="filePF"
            />
          </div>
          <div class="dx-fieldset">
            <div class="dx-fieldset-header">Remarks</div>
            <DxTextArea
              :height="90"
              :read-only="true"
              :value="DataStatutory.Remarks"
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
import { DxSimpleItem, DxGroupItem } from 'devextreme-vue/form';
import CrudService from '../services/crud.service';
import LocalStorageService from '../LocalStorageService';
import DxButton from 'devextreme-vue/button';
import globalConfig from '../config/GlobalConfig.vue';
import { alert, confirm } from 'devextreme/ui/dialog';
const localStorageService = LocalStorageService.getService();
const dataGridRef = 'data-grid';
import {
  DxPopup as MyPopup,
  DxPosition as MyPosition,
  DxToolbarItem as MyToolbar,
} from 'devextreme-vue/popup';
export default {
  components: {
    MyPopup,
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
    const uploadPVS = globalConfig.backendAPIURL + 'statutoryho/PetaVerifySementara/';
    const uploadPF = globalConfig.backendAPIURL + 'statutoryho/PetaFinal/';
    const filePVS = '';
    const filePF = '';
    const popupVisible = false;
    const DataStatutory = {};
    const fileAdded = false;
    const Grid = {};
    const store = new CustomStore({
      key: 'id',
      load: function () {
        return CrudService.getAll('statutoryho/index');
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
          return CrudService.updateData('statutoryho/update/statutoryUpdate', key, values);
        }
      },
    });

    return {
      dataSource: store,
      dataGridRef,
      Access,
      VAccess,
      header,
      uploadPVS,
      uploadPF,
      filePVS,
      filePF,
      DataStatutory,
      popupVisible,
      Grid,
      fileAdded,
      verifyOptions: {
        icon: 'check',
        type: 'success',
        text: 'Verify Document',
        onClick: () => {
          let result = confirm(
            '<i>Are you sure to verify?<br><h4>Pastikan Peta Final sudah di upload sebelum anda verifikasi! ☺</h4></i>',
            
            'Confirm changes'
          );
          result.then((dialogResult) => {
            if (dialogResult) {
              this.popupVisible = false;
              return CrudService.updateData('verifystatutory', this.DataStatutory.id, {
                action: 'verify',
              }).then(() => {
                this.Grid.refresh();
              });
            }
          });
        },
      },
      reupOptions: {
        icon: 'plus',
        type: 'default',
        text: 'Request Peta Final',
        onClick: () => {
          let result = confirm(
            '<i>Are you sure you want to request a final map upload??</i>',
            'Confirm changes'
          );
          result.then((dialogResult) => {
            if (dialogResult) {
              this.popupVisible = false;
              Swal.fire({
                title: 'Remarks',
                input: 'text',
                inputAttributes: {
                  autocapitalize: 'off',
                },
                showCancelButton: true,
                confirmButtonText: 'Submit',
                showLoaderOnConfirm: true,
                preConfirm: (reason) => {
                  return CrudService.updateData('verifystatutory', this.DataStatutory.id, {
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
        type: 'danger',
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
    remindIconClick(e) {
      let result = confirm(
        '<i>Are you sure to send email reminder?</i>',
        'Confirm changes'
      );
      result.then((dialogResult) => {
        if (dialogResult) {
          return CrudService.updateData('verifystatutory', e.data.id, {
            action: 'reminder',
          }).then((response) => {
            if (response.status === 'success')
              alert('Email Reminder sent', 'Information');
          });
        }
      });
    },
    reuploadIconClick(e) {
      let result = confirm(
        '<i>Are you sure to send email reminder?</i>',
        'Confirm changes'
      );
      result.then((dialogResult) => {
        if (dialogResult) {
          return CrudService.updateData('verifystatutory', e.data.id, {
            action: 'reupload',
          }).then((response) => {
            if (response.status === 'success')
              alert('Email Reminder sent', 'Information');
          });
        }
      });
    },
    verifyIconClick(e) {
      this.DataStatutory = e.data;
      this.filePVS = e.data.Peta_verify_sementara? e.data.Peta_verify_sementara.split('/') : '';
      this.filePF = e.data.Peta_final ? e.data.Peta_final.split('/') : '';
      this.popupVisible = true;
    },
    downloadfile(e) {
      window.open(globalConfig.backendBASEURL + e.value, '_blank');
    },
    deleteFile(e) {
      if (e.columnIndex == 18) this.filePVS = '';
      if (e.columnIndex == 19) this.filePF = '';
      e.setValue('');
    },
    onExporting(e) {
      const workbook = new ExcelJS.Workbook();
      const worksheet = workbook.addWorksheet('statutoryho');

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
      this.uploadPVS = globalConfig.backendAPIURL + 'statutoryho/PetaVerifySementara/' + e.data.id;
      this.uploadPF = globalConfig.backendAPIURL + 'statutoryho/PetaFinal/' + e.data.id;
      this.filePVS = e.data.Peta_verify_sementara ? e.data.Peta_verify_sementara.split('/') : '';
      this.filePF = e.data.Peta_final ? e.data.Peta_final.split('/') : '';
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
          e.data.Statutory_UploadStatus === 3 ||
          e.data.Statutory_UploadStatus === '3' ||
          e.data.Statutory_UploadStatus === '2' ||
          e.data.Statutory_UploadStatus === 2
        ) {
          e.cellElement.innerHTML = '';
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
    },
    refreshDataGrid() {
      this.Grid.refresh();
    },
    onInitialized(e) {
      this.Grid = e.component;
    },
    onPVSValueChanged(e) {
      this.fileAdded = true;
      e.component.option('uploadUrl', this.uploadPVS);
    },
    onPFValueChanged(e) {
      this.fileAdded = true;
      e.component.option('uploadUrl', this.uploadPF);
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
    CrudService.findData('accessroles/check', { module: 'StatutoryHO' }).then(
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
      module: 'VerifyStatutory',
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

