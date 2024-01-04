<template>
  <div class="py-12">
    <panel title="Final Document">
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
              <DxSimpleItem data-field="Kategori" :editor-options="{disabled: true}"/>
              <DxSimpleItem data-field="Featno_Baru" :editor-options="{placeholder: 'Contoh A123'}">
                <DxStringLengthRule :min="4" message="Default format featno A123"/>
                <DxRequiredRule message="Featno is required"/>
              </DxSimpleItem>
              <DxGroupItem caption=""></DxGroupItem>
              <DxGroupItem caption="Lampiran Peta Baru">
                <DxSimpleItem data-field="Lampiran_petabaru" :label="{ text: ' ' }"  ></DxSimpleItem>
              </DxGroupItem> 
              <DxGroupItem caption="Lampiran Final PCCR">
                <DxSimpleItem data-field="Lampiran_finalpccr" :label="{ text: ' ' }"  ></DxSimpleItem>
              </DxGroupItem> 
              <DxGroupItem caption="Remarks">
                <DxSimpleItem :editor-options="{ height: 100 }" editor-type="dxTextArea" data-field="Final_Remarks" :label="{ text: ' ' }"/>
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
            :fixed="true"
            fixed-position="left"
            :allow-fixing="false"
            data-field="id"
            caption="Action"
            header-cell-template="template-header"
            cell-template="verifyFinalTemplate"
          />
          <DxColumn
            data-field="Sector"
            data-type="string"
            :fixed="true"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Estate"
            data-type="string"
            :fixed="true"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Featno"
            data-type="string"
            caption="FeatNo"
            :fixed="true"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Kategori"
            data-type="string"
            :fixed="true"
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
            data-type="string"
            :fixed="true"
            caption="FeatNo Baru"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="SPECIESID "
            data-type="string"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Statusrequest"
            data-type="string"

            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Final_Remarks"
            data-type="string"
            caption="Remarks"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Final_Reupload_Remarks"
            data-type="string"
            caption="Reupload Remarks"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Final_UploadStatus"
            data-type="string"
            cell-template="status-cell-template"
            header-cell-template="template-header"
            caption="Doc Status"
          />
          <DxColumn
            data-field="UploadBy_namefinal"
            data-type="string"
            caption="UploadBy"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Final_Upload_Date"
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
            data-field="Lampiran_petabaru"
            data-type="string"
            caption="Lampiran Peta Baru"
            cell-template="DownloadTemplate"
            edit-cell-template="editPetaBaruTemplate"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Lampiran_finalpccr"
            data-type="string"
            caption="Lampiran Final PCCR"
            cell-template="DownloadTemplate"
            edit-cell-template="editPCCRTemplate"
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

          <template #editPetaBaruTemplate="{ data }">
            <div>
              <span v-if="filepeta"
                >Current file : <b>{{ filepeta[4] }}</b></span
              ><br />
              <DxButton
                :cell-data="data"
                hint="Download File"
                styling-mode="outlined"
                icon="download"
                type="default"
                @click="downloadfile(data)"
                v-if="filepeta"
                
              />
              <DxButton
                :cell-data="data"
                hint="Delete File"
                styling-mode="outlined"
                icon="remove"
                type="default"
                @click="deleteFile(data)"
                v-if="filepeta"
              />
              <DxFileUploader
               :multiple="false"
                accept="image/png,application/pdf,image/jpeg"
                upload-mode="instantly"
                :upload-url="uploadpeta"
                :upload-headers="header"
                :max-file-size="5242880"
                @value-changed="onPetaValueChanged"
                @uploaded="(e) => onUploaded(e, data)"
              />
            </div>
          </template>

          <template #editPCCRTemplate="{ data }">
            <div>
              <span v-if="filepccr"
                >Current file : <b>{{ filepccr[4] }}</b></span
              ><br />
              <DxButton
                :cell-data="data"
                hint="Download File"
                styling-mode="outlined"
                icon="download"
                type="default"
                @click="downloadfile(data)"
                v-if="filepccr"
                
              />
              <DxButton
                :cell-data="data"
                hint="Delete File"
                styling-mode="outlined"
                icon="remove"
                type="default"
                @click="deleteFile(data)"
                v-if="filepccr"
              />
              <DxFileUploader
               :multiple="false"
                accept="image/png,application/pdf,image/jpeg"
                upload-mode="instantly"
                :upload-url="uploadpccr"
                :upload-headers="header"
                :max-file-size="5242880"
                @value-changed="onPccrValueChanged"
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
          <template #verifyFinalTemplate="{ data: cellData }">
            <div>
              <DxButton
                :cell-data="cellData"
                :visible="
                  (cellData.data.Final_UploadStatus === '2' ||
                    cellData.data.Final_UploadStatus === 2) &&
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
                  (cellData.data.Final_UploadStatus === '1' ||
                    cellData.data.Final_UploadStatus === 1) &&
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
                  (cellData.data.Final_UploadStatus === '2' ||
                    cellData.data.Final_UploadStatus === 2) &&
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
              <div class="dx-fieldset-header">Lampiran Peta Baru (image / pdf)</div>
              <div v-if="filepeta">
                File Name : <b>{{ filepeta[4] }}</b>
              </div>
              <div v-else>File not uploaded</div>
              <DxButton
                hint="Download Peta Baru"
                styling-mode="outlined"
                icon="download"
                type="default"
                @click="Download(Data.Lampiran_petabaru)"
                v-if="filepeta"
              />
            </div>
          </div>
          <div class="form">
            <div class="dx-fieldset">
              <div class="dx-fieldset-header">Lampiran Final PCCR (image / pdf)</div>
              <div v-if="filepccr">
                File Name : <b>{{ filepccr[4] }}</b>
              </div>
              <div v-else>File not uploaded</div>
              <DxButton
                hint="Download Final PCCR"
                styling-mode="outlined"
                icon="download"
                type="default"
                @click="Download(Data.Lampiran_finalpccr)"
                v-if="filepccr"
              />
            </div>
          </div>
          <div class="dx-fieldset">
            <div class="dx-fieldset-header">Remarks</div>
            <DxTextArea
              :height="90"
              :read-only="true"
              :value="Data.Final_Remarks"
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
  DxColumnFixing,
  DxHeaderFilter,
  DxFilterRow,
} from 'devextreme-vue/data-grid';
import CustomStore from 'devextreme/data/custom_store';
import { exportDataGrid } from 'devextreme/excel_exporter';
import ExcelJS from 'exceljs';
import saveAs from 'file-saver';
import Swal from 'sweetalert2';
import { DxSimpleItem, DxGroupItem,DxStringLengthRule,DxRequiredRule } from 'devextreme-vue/form';
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
    DxRequiredRule,
    DxStringLengthRule,
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
    const uploadpeta = globalConfig.backendAPIURL + 'registersplitfinal/Lampiran_petabaru/';
    const uploadpccr = globalConfig.backendAPIURL + 'registersplitfinal/Lampiran_finalpccr/';
    const filepeta = '';
    const filepccr = '';
    const popupVisible = false;
    const Data = {};
    const fileAdded = false;
    const Grid = {};
    const store = new CustomStore({
     key :'id',
      load: function () {
          //registersplitupload/indexupload di ambil dari route
        return CrudService.getAll('registersplitfinal/index');
      },

      update: (key, values) => {
        if (this.fileAdded) {
          alert(
            'Update Failed, Please finish all your upload before you can save the data',
            'Error'
          );
          return false;
        } else {
          return CrudService.updateData('registersplitfinal/update/Upload', key, values);
        }
      },

    });
    return {
      dataSource: store,
      Access,
      VAccess,
      header,
      uploadpeta,
      uploadpccr,
      filepeta,
      filepccr,
      Data,
      popupVisible,
      Grid,
      fileAdded,
      // featnoEditorOptions: {minSearchLength: 4},
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
              return CrudService.updateData('verifyregistersplitfinal', this.Data.id, {
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
                  return CrudService.updateData('verifyregistersplitfinal', this.Data.id, {
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
    calculateCellValue(rowData) {
      return rowData.Estate + rowData.Featno_Baru;
    },
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
          return CrudService.updateData('verifyregistersplitfinal', e.data.id, {
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
          return CrudService.updateData('verifyregistersplitfinal', e.data.id, {
            action: 'reupload',
          }).then((response) => {
            if (response.status === 'success')
              alert('Email Reminder sent', 'Information');
          });
        }
      });
    },
    verifyIconClick(e) {
      this.Data = e.data;
      this.filepeta = e.data.Lampiran_petabaru ? e.data.Lampiran_petabaru.split('/') : '';
      this.filepccr = e.data.Lampiran_finalpccr ? e.data.Lampiran_finalpccr.split('/') : '';
      this.popupVisible = true;
    },
    downloadfile(e) {
      window.open(globalConfig.backendBASEURL + e.value, '_blank');
    },
    deleteFile(e) {
      if (e.columnIndex == 16) this.filepeta = '';
      e.setValue('');
    },
    onExporting(e) {
      const workbook = new ExcelJS.Workbook();
      const worksheet = workbook.addWorksheet('Registersplitfinal');

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
      this.uploadpeta = globalConfig.backendAPIURL + 'registersplitfinal/Lampiran_petabaru/' + e.data.id;
      this.uploadpccr = globalConfig.backendAPIURL + 'registersplitfinal/Lampiran_finalpccr/' + e.data.id;
      this.filepeta = e.data.Lampiran_petabaru ? e.data.Lampiran_petabaru.split('/') : '';
      this.filepccr = e.data.Lampiran_finalpccr ? e.data.Lampiran_finalpccr.split('/') : '';
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
          e.data.Final_UploadStatus === 3 ||
          e.data.Final_UploadStatus === '3' ||
          e.data.Final_UploadStatus === '2' ||
          e.data.Final_UploadStatus === 2
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
    onPetaValueChanged(e) {
      this.fileAdded = true;
      e.component.option('uploadUrl', this.uploadpeta);
    },
    onPccrValueChanged(e) {
      this.fileAdded = true;
      e.component.option('uploadUrl', this.uploadpccr);
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
    CrudService.findData('accessroles/check', { module: 'Registersplitfinal' }).then(
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
      module: 'VerifyRegistersplitfinal',
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

