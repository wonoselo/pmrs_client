<template>
  <div class="py-12">
    <panel title="Upload Document">
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
              title="Upload Data"
            >
              <DxPosition my="center" at="center" of="window" />
            </DxPopup>
            <DxForm :col-count="2" :show-colon-after-label="false">
                <DxSimpleItem data-field="Sector" :editor-options="{disabled: true}" />
                <DxSimpleItem data-field="Estate" :editor-options="{disabled: true}"/>
                <DxSimpleItem data-field="Featno" :editor-options="{disabled: true}"/>     
                <DxSimpleItem data-field="Pola" :editor-options="{disabled: true}"/>
                <DxSimpleItem data-field="No_KTP_Claimer" :editor-options="{disabled: true}"/>
                <DxSimpleItem data-field="Luas" :editor-options="{disabled: true}"/>
              <DxGroupItem caption="Upload KTP">
                <DxSimpleItem data-field="Ktp" :label="{ text: ' ' }"  />
              </DxGroupItem>  
              <DxGroupItem caption="Surat Claim">
                <DxSimpleItem data-field="Surat_Claim" :label="{ text: ' ' }"  />
              </DxGroupItem> 
              <DxGroupItem caption="Remarks">
                <DxSimpleItem
                  :editor-options="{ height: 100 }"
                  editor-type="dxTextArea"
                  data-field="Remarks"
                  :label="{ text: ' ' }"
                />
              </DxGroupItem>          
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
            :width="50"
            :allow-grouping="false"
            :allow-filtering="false"
            :allow-editing="false"
            :fixed="false"
            fixed-position="left"
            :allow-fixing="false"
            data-field="id"
            caption="Action"
            header-cell-template="template-header"
            cell-template="verifyTemplate"
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
            data-type="string"
            caption="Luas (Ha)"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="resttime_req"
            data-type="string"
            caption="Deadline Verification"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Remarks"
            data-type="string"
            caption="Remarks"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="UploadStatus"
            data-type="string"
            cell-template="status-cell-template"
            header-cell-template="template-header"
            caption="Doc Status"
          />
          <DxColumn
            data-field="ReqUpload_name"
            data-type="string"
            caption="Req UploadBy"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Req_Upload_Date"
            data-type="date"
            format="dd/MM/yyyy"
            caption="Req UploadDate"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Ktp"
            data-type="string"
            caption="KTP"
            cell-template="DownloadTemplate"
            edit-cell-template="editktpTemplate"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Surat_Claim"
            data-type="string"
            caption="Surat Claim"
            cell-template="DownloadTemplate"
            edit-cell-template="editClaimTemplate"
            header-cell-template="template-header"
          />

          <!-- END DATA TABLE -->

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

          <template #editktpTemplate="{ data }">
            <div>
              <span v-if="filektp"
                >Current file : <b>{{ filektp[4] }}</b></span
              ><br />
              <DxButton
                :cell-data="data"
                hint="Download File"
                styling-mode="outlined"
                icon="download"
                type="default"
                @click="downloadfile(data)"
                v-if="filektp"
                
              />
              <DxButton
                :cell-data="data"
                hint="Delete File"
                styling-mode="outlined"
                icon="remove"
                type="default"
                @click="deleteFile(data)"
                v-if="filektp"
              />
              <DxFileUploader
               :multiple="false"
                accept="image/png,application/pdf,image/jpeg"
                upload-mode="instantly"
                :upload-url="uploadktp"
                :upload-headers="header"
                :max-file-size="5242880"
                @value-changed="onKtpValueChanged"
                @uploaded="(e) => onUploaded(e, data)"
              />
            </div>
          </template>

          <template #editClaimTemplate="{ data }">
            <div>
              <span v-if="fileclaim"
                >Current file : <b>{{ fileclaim[4] }}</b></span
              ><br />
              <DxButton
                :cell-data="data"
                hint="Download File"
                styling-mode="outlined"
                icon="download"
                type="default"
                @click="downloadfile(data)"
                v-if="fileclaim"
                
              />
              <DxButton
                :cell-data="data"
                hint="Delete File"
                styling-mode="outlined"
                icon="remove"
                type="default"
                @click="deleteFile(data)"
                v-if="fileclaim"
              />
              <DxFileUploader
               :multiple="false"
                accept="image/png,application/pdf,image/jpeg"
                upload-mode="instantly"
                :upload-url="uploadclaim"
                :upload-headers="header"
                :max-file-size="5242880"
                @value-changed="onClaimValueChanged"
                @uploaded="(e) => onUploaded(e, data)"
              />
            </div>
          </template>

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
          <!-- button dalam colom action -->
          <template #verifyTemplate="{ data: cellData }">
            <div>
              <DxButton
                :cell-data="cellData"
                :visible="
                  (cellData.data.UploadStatus === '2' ||
                    cellData.data.UploadStatus === 2) &&
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
                  (cellData.data.UploadStatus === '1' ||
                    cellData.data.UploadStatus === 1) &&
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
                  (cellData.data.UploadStatus === '2' ||
                    cellData.data.UploadStatus === 2) &&
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
          <!-- End button dalam colom action -->

        </DxDataGrid>
        
      </div>
    </panel>
    <!-- Popup verifikasi dalam colom action -->
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
            <div class="dx-fieldset-header">KTP (image / pdf)</div>
            <div v-if="filektp">
              File Name : <b>{{ filektp[4] }}</b>
            </div>
            <div v-else>File not uploaded</div>
            <DxButton
              hint="Download FileUpload"
              styling-mode="outlined"
              icon="download"
              type="default"
              @click="Download(DataReq.Ktp)"
              v-if="filektp"
            />
          </div>
        </div>
        <div class="form">
          <div class="dx-fieldset">
            <div class="dx-fieldset-header">Surat Claim (image / pdf)</div>
            <div v-if="fileclaim">
              File Name : <b>{{ fileclaim[4] }}</b>
            </div>
            <div v-else>File not uploaded</div>
            <DxButton
              hint="Download FileUpload"
              styling-mode="outlined"
              icon="download"
              type="default"
              @click="Download(DataReq.Surat_Claim)"
              v-if="fileclaim"
            />
          </div>
        </div>
        <div class="dx-fieldset">
          <div class="dx-fieldset-header">Remarks</div>
          <DxTextArea
            :height="90"
            :read-only="true"
            :value="DataReq.Remarks"
          />
        </div>
      </div>
    </MyPopup>

    <!--End Popup verifikasi dalam colom action-->
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
      AllowView: true,
      AllowAdd: true,
      AllowEdit: true,
      AllowDelete: true,
    };
    const VAccess = {
      AllowView: true,
      AllowAdd: true,
      AllowEdit: true,
      AllowDelete: true,
    };
    const token = localStorageService.getAccessToken();
    const header = { Authorization: 'Bearer ' + token };
    const uploadktp = globalConfig.backendAPIURL + 'reqssl/KTP/';
    const uploadclaim = globalConfig.backendAPIURL + 'reqssl/SuratClaim';
    const filektp = '';
    const fileclaim = '';
    const popupVisible = false;
    const DataReq = {};
    const fileAdded = false;
    const Grid = {};
    const store = new CustomStore({
     key :'id',
      load: function () {
          //uploadssl/indexupload di ambil dari route
        return CrudService.getAll('uploadssl/indexupload');
      },

      update: (key, values) => {
        if (this.fileAdded) {
          alert(
            'Update Failed, Please finish all your upload before you can save the data',
            'Error'
          );
          return false;
        } else {
          return CrudService.updateData('reqssl/update/ReqSsl', key, values);
        }
      },

    });
    return {
      dataSource: store,
      Access,
      VAccess,
      header,
      uploadktp,
      uploadclaim,
      filektp,
      fileclaim,
      DataReq,
      popupVisible,
      Grid,
      fileAdded,
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
              return CrudService.updateData('verifyreq', this.DataReq.id, {
                action: 'verify',
              }).then(() => {
                this.Grid.refresh();
              });
            }
          });
        },
      },
      reupOptions: {
        icon: 'remove',
        type: 'danger',
        text: 'Ask Reupload',
        onClick: () => {
          let result = confirm(
            '<i>Are you sure to ask for reupload?</i>',
            'Confirm changes'
          );
          result.then((dialogResult) => {
            if (dialogResult) {
              this.popupVisible = false;
              Swal.fire({
                title: 'Please add reason for reupload',
                input: 'text',
                inputAttributes: {
                  autocapitalize: 'off',
                },
                showCancelButton: true,
                confirmButtonText: 'Submit',
                showLoaderOnConfirm: true,
                preConfirm: (reason) => {
                  return CrudService.updateData('verifyreq', this.DataReq.id, {
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
    remindIconClick(e) {
      let result = confirm(
        '<i>Are you sure to send email reminder?</i>',
        'Confirm changes'
      );
      result.then((dialogResult) => {
        if (dialogResult) {
          return CrudService.updateData('verifyreq', e.data.id, {
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
          return CrudService.updateData('verifyreq', e.data.id, {
            action: 'reupload',
          }).then((response) => {
            if (response.status === 'success')
              alert('Email Reminder sent', 'Information');
          });
        }
      });
    },
    verifyIconClick(e) {
      this.DataReq = e.data;
      this.filektp = e.data.Ktp ? e.data.Ktp.split('/') : '';
      this.fileclaim = e.data.Surat_Claim ? e.data.Surat_Claim.split('/') : '';
      this.popupVisible = true;
    },
    downloadfile(e) {
      window.open(globalConfig.backendBASEURL + e.value, '_blank');
    },
    deleteFile(e) {
      if (e.columnIndex == 18) this.filektp = '';
      if (e.columnIndex == 19) this.fileclaim = '';
      e.setValue('');
    },
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
    onEditingStart(e) {
      this.uploadktp = globalConfig.backendAPIURL + 'reqssl/KTP/' + e.data.id;
      this.uploadclaim = globalConfig.backendAPIURL + 'reqssl/SuratClaim/' + e.data.id;
      this.filektp = e.data.Ktp ? e.data.Ktp.split('/') : '';
      this.fileclaim = e.data.Surat_Claim ? e.data.Surat_Claim.split('/') : '';
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
          e.data.UploadStatus === 3 ||
          e.data.UploadStatus === '3' ||
          e.data.UploadStatus === '2' ||
          e.data.UploadStatus === 2
        ) {
          e.cellElement.innerHTML = '';
        }
      }
    },
    refreshDataGrid() {
      this.Grid.refresh();
    },
    onInitialized(e) {
      this.Grid = e.component;
    },
    onKtpValueChanged(e) {
      this.fileAdded = true;
      e.component.option('uploadUrl', this.uploadktp);
    },
    onClaimValueChanged(e) {
      this.fileAdded = true;
      e.component.option('uploadUrl', this.uploadclaim);
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
    CrudService.findData('accessroles/check', { module: 'UploadSSL' }).then(
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
      module: 'VerifyRequest',
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

