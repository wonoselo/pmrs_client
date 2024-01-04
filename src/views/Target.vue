<template>
  <div class="py-12">
    <panel title="Target GPS Measurement Sector">
      <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
        <DxDataGrid :data-source="dataSource" :repaint-changes-only="true" @editing-start="onEditingStart"
          @cell-prepared="onCellPrepared" @toolbar-preparing="onToolbarPreparing($event)" :allow-column-resizing="true"
          @initialized="onInitialized" :show-borders="true" column-resizing-mode="widget" :column-auto-width="true"
          :show-column-lines="true" :remote-operations="false" :row-alternation-enabled="true"
          :column-hiding-enabled="false">
          <DxEditing :allow-updating="Access.AllowEdit" :allow-adding="false" :allow-deleting="false" :use-icons="true"
            mode="popup">
            <DxPopup :width="600" :show-title="true" title="Upload GPS Document">
              <DxPosition my="top" at="top" of="window" />
            </DxPopup>
            <DxForm :col-count="1" :show-colon-after-label="false">
              <DxGroupItem caption="Tally Sheet (image / pdf)">
                <DxSimpleItem data-field="TalySheet" :label="{ text: ' ' }" />
              </DxGroupItem>
              <DxGroupItem caption="Shape File (zip)">
                <DxSimpleItem data-field="ShapeFile" :label="{ text: ' ' }" />
              </DxGroupItem>
              <DxGroupItem caption="Foto Udara">
                <DxSimpleItem :editor-options="{ height: 40 }" editor-type="dxTextArea" data-field="FotoUdara"
                  :label="{ text: ' ' }" />
              </DxGroupItem>
              <DxGroupItem caption="Peta Kerja (image/pdf)">
                <DxSimpleItem data-field="FileBAP" :label="{ text: ' ' }" />
              </DxGroupItem>
              <DxGroupItem caption="Form Join Check (image/pdf)">
                <DxSimpleItem data-field="FileJoinCheck" :label="{ text: ' ' }" />
              </DxGroupItem>
              <DxGroupItem caption="Remarks">
                <DxSimpleItem :editor-options="{ height: 100 }" editor-type="dxTextArea" data-field="GPS_DocRemarks"
                  :label="{ text: ' ' }" />
              </DxGroupItem>
            </DxForm>
          </DxEditing>
          <DxColumn type="buttons" :width="50" :fixed="true" caption="Upload" :visible="Access.AllowEdit"
            fixed-position="left" header-cell-template="template-header" :allow-fixing="false" />
          <DxColumn :width="50" :allow-grouping="false" :allow-filtering="false" :allow-editing="false" :fixed="true"
            fixed-position="left" :allow-fixing="false" data-field="id" caption="Action"
            header-cell-template="template-header" cell-template="verifyTemplate" />
          <DxColumn data-field="SECTOR" :fixed="true" fixed-position="left" :allow-fixing="false" data-type="string"
            caption="Sect" :width="60" header-cell-template="template-header" />
          <DxColumn data-field="ESTATE" :fixed="true" fixed-position="left" :allow-fixing="false" :width="50"
            caption="Est" data-type="string" header-cell-template="template-header" />
          <DxColumn data-field="FEATNO" :fixed="true" fixed-position="left" :allow-fixing="false" data-type="string"
            caption="FeatNo" :width="70" header-cell-template="template-header" />
          <DxColumn data-field="WO_NUMBER" :fixed="true" fixed-position="left" :allow-fixing="false" data-type="string"
            :width="100" caption="WO Number" header-cell-template="template-header" />
          <DxColumn data-field="JCOC" :fixed="true" fixed-position="left" :allow-fixing="false" :width="65"
            data-type="string" header-cell-template="template-header" caption="JC/OC" />
          <DxColumn data-field="DAYS_FROM_CPR" :fixed="true" fixed-position="left" :allow-fixing="false" :width="125"
            data-type="string" header-cell-template="template-header" caption="DAYS FROM CPR" />
          <DxColumn data-field="JCOC_DESC" data-type="string" :width="150" header-cell-template="template-header"
            caption="JC/OC Desc" />
          <DxColumn data-field="CONT_NAME" data-type="string" :width="125" header-cell-template="template-header"
            caption="Contractor" />
          <DxColumn data-field="REQ_DATE" data-type="date" format="dd/MM/yyyy" :width="85"
            header-cell-template="template-header" caption="CPR Date" />
          <DxColumn data-field="CPR_TO_UPLOAD" data-type="string" :width="125" header-cell-template="template-header"
            caption="CPR to UPLOAD" />
          <DxColumn data-field="Status_GPS" data-type="string" :width="95" header-cell-template="template-header"
            caption="Status GPS" />
          <DxColumn data-field="REQ_SIZE" data-type="number" :width="80" header-cell-template="template-header"
            caption="CPR Size" />
          <DxColumn data-field="GPS_Upload_Date" data-type="datetime" format="dd/MM/yyyy H:m" :width="110"
            header-cell-template="template-header" caption="GPS Upload" />
          <DxColumn data-field="UploadStatus" data-type="string" :width="100" cell-template="status-cell-template"
            header-cell-template="template-header" caption="Doc Status" />
          <DxColumn data-field="GPS_DocRemarks" data-type="string" caption="Doc Remarks" :width="125"
            header-cell-template="template-header" />
          <DxColumn data-field="GPS_ReuploadRemarks" data-type="string" caption="Reupload Comments" :width="125"
            header-cell-template="template-header" />
          <DxColumn data-field="GPS_DATE" data-type="date" format="dd/MM/yyyy" :width="85"
            header-cell-template="template-header" caption="GPS Date" />
          <DxColumn data-field="QS_DATE" data-type="date" format="dd/MM/yyyy" :width="80"
            header-cell-template="template-header" caption="QS Date" />
          <DxColumn data-field="QC_DATE" data-type="date" format="dd/MM/yyyy" :width="80"
            header-cell-template="template-header" caption="QC Date" />
          <DxColumn data-field="FileJoinCheck" :width="130" caption="Form Join Check" data-type="string"
            cell-template="talyTemplate" edit-cell-template="editJoincekTemplate"
            header-cell-template="template-header" />
          <DxColumn data-field="TalySheet" :width="90" data-type="string" cell-template="talyTemplate"
            edit-cell-template="editTalyTemplate" header-cell-template="template-header" />
          <DxColumn data-field="FotoUdara" data-type="string" caption="Foto Udara" :width="125"
            header-cell-template="template-header" />
          <DxColumn data-field="ShapeFile" :width="90" caption="Shape File" data-type="string"
            cell-template="talyTemplate" edit-cell-template="editSHPTemplate" header-cell-template="template-header" />
          <DxColumn data-field="FileBAP" :width="90" caption="Peta Kerja" data-type="string" cell-template="talyTemplate"
            edit-cell-template="editBAPTemplate" header-cell-template="template-header" />

          <DxExport :enabled="true" :allow-export-selected-data="true" />
          <DxColumnChooser :enabled="true" />
          <DxColumnFixing :enabled="false" />
          <DxSearchPanel :visible="true" :highlight-case-sensitive="true" />
          <DxHeaderFilter :visible="true" />
          <DxFilterRow :visible="true" />
          <DxPaging :page-size="20" />
          <DxPager :show-page-size-selector="true" :allowed-page-sizes="[20, 50, 100]" />
          <template #template-header="{ data }">
            <span style="color: navy; font-weight: bold; font-size: 9pt">{{
              data.column.caption
            }}</span>
          </template>
          <template #talyTemplate="{ data: cellData }">
            <DxButton :cell-data="cellData" hint="Download File" styling-mode="outlined" icon="download" type="default"
              @click="downloadfile(cellData)" v-if="cellData.value" />
          </template>
          <template #editTalyTemplate="{ data }">
            <div>
              <span v-if="fileTaly">Current file : <b>{{ fileTaly[4] }}</b></span><br />
              <DxButton :cell-data="data" hint="Download File" styling-mode="outlined" icon="download" type="default"
                @click="downloadfile(data)" v-if="fileTaly" />
              <DxButton :cell-data="data" hint="Delete File" styling-mode="outlined" icon="remove" type="default"
                @click="deleteFile(data)" v-if="fileTaly" />
              <DxFileUploader :multiple="true" accept="image/png,application/pdf,image/jpeg" upload-mode="instantly"
                :upload-url="uploadTally" :upload-headers="header" :max-file-size="5242880"
                @value-changed="onTalyValueChanged" @uploaded="(e) => onUploaded(e, data)" />
            </div>
          </template>
          <template #editUkurTemplate="{ data }">
            <div>
              <span v-if="fileUkur">Current file :<b>{{ fileUkur[4] }}</b></span><br />
              <DxButton :cell-data="data" hint="Download File" styling-mode="outlined" icon="download" type="default"
                @click="downloadfile(data)" v-if="fileUkur" />
              <DxButton :cell-data="data" hint="Delete File" styling-mode="outlined" icon="remove" type="default"
                @click="deleteFile(data)" v-if="fileUkur" />
              <DxFileUploader :multiple="false" accept="application/zip" upload-mode="instantly" :upload-url="uploadUkur"
                :upload-headers="header" :max-file-size="5242880" @value-changed="onUkurValueChanged"
                @uploaded="(e) => onUploaded(e, data)" />
            </div>
          </template>
          <template #editSHPTemplate="{ data }">
            <div>
              <span v-if="fileSHP">Current file : <b>{{ fileSHP[4] }}</b></span><br />
              <DxButton :cell-data="data" hint="Download File" styling-mode="outlined" icon="download" type="default"
                @click="downloadfile(data)" v-if="fileSHP" />
              <DxButton :cell-data="data" hint="Delete File" styling-mode="outlined" icon="remove" type="default"
                @click="deleteFile(data)" v-if="fileSHP" />
              <DxFileUploader :multiple="false" accept="application/zip" upload-mode="instantly" :upload-url="uploadSHP"
                :upload-headers="header" :max-file-size="5242880" @value-changed="onSHPValueChanged"
                @uploaded="(e) => onUploaded(e, data)" />
            </div>
          </template>
          <template #editBAPTemplate="{ data }">
            <div>
              <span v-if="fileBAP">Current file : <b>{{ fileBAP[4] }}</b></span><br />
              <DxButton :cell-data="data" hint="Download File" styling-mode="outlined" icon="download" type="default"
                @click="downloadfile(data)" v-if="fileBAP" />
              <DxButton :cell-data="data" hint="Delete File" styling-mode="outlined" icon="remove" type="default"
                @click="deleteFile(data)" v-if="fileBAP" />
              <DxFileUploader :multiple="false" accept="image/png,application/pdf,image/jpeg" upload-mode="instantly"
                :upload-url="uploadBAP" :upload-headers="header" :max-file-size="5242880"
                @value-changed="onBAPValueChanged" @uploaded="(e) => onUploaded(e, data)" />
            </div>
          </template>
          <template #editJoincekTemplate="{ data }">
            <div>
              <span v-if="fileJoincek">Current file : <b>{{ fileJoincek[4] }}</b></span><br />
              <DxButton :cell-data="data" hint="Download File" styling-mode="outlined" icon="download" type="default"
                @click="downloadfile(data)" v-if="fileJoincek" />
              <DxButton :cell-data="data" hint="Delete File" styling-mode="outlined" icon="remove" type="default"
                @click="deleteFile(data)" v-if="fileJoincek" />
              <DxFileUploader :multiple="false" accept="image/png,application/pdf,image/jpeg" upload-mode="instantly"
                :upload-url="uploadJoincek" :upload-headers="header" :max-file-size="5242880"
                @value-changed="onJoincekValueChanged" @uploaded="(e) => onUploaded(e, data)" />
            </div>
          </template>
          <template #status-cell-template="{ data }">
            <div>
              <div class="badge badge-success" v-if="data.value == 2">
                Waiting Verification
              </div>
              <div class="badge badge-warning" v-else-if="data.value == 1">
                Need Reupload
              </div>
              <div class="badge badge-default" v-else>Not Yet Upload</div>
            </div>
          </template>
          <template #verifyTemplate="{ data: cellData }">
            <div>
              <DxButton :cell-data="cellData" :visible="
                (cellData.data.UploadStatus === '2' ||
                  cellData.data.UploadStatus === 2) &&
                VAccess.AllowEdit
              " hint="Verify File Ukur Documents" styling-mode="outlined" icon="check" type="default"
                @click="verifyIconClick(cellData)" />
              <DxButton :cell-data="cellData" :visible="
                (cellData.data.UploadStatus === '1' ||
                  cellData.data.UploadStatus === 1) &&
                VAccess.AllowEdit
              " hint="Send Reminder" styling-mode="outlined" icon="warning" type="default"
                @click="reuploadIconClick(cellData)" />
              <DxButton :cell-data="cellData" :visible="
                (cellData.data.UploadStatus === '2' ||
                  cellData.data.UploadStatus === 2) &&
                Access.AllowEdit
              " hint="Send Reminder" styling-mode="outlined" icon="warning" type="default"
                @click="remindIconClick(cellData)" />
            </div>
          </template>
        </DxDataGrid>
      </div>
    </panel>
    <MyPopup :visible="popupVisible" :drag-enabled="false" :close-on-outside-click="false" :show-close-button="false"
      :show-title="true" :width="400" :height="600" :shading="true" container=".dx-viewport" title="Chose Action">
      <MyPosition at="center" my="center" of="window" />
      <MyToolbar widget="dxButton" toolbar="bottom" location="before" :options="verifyOptions" />
      <MyToolbar widget="dxButton" toolbar="bottom" location="before" :options="reupOptions" />
      <MyToolbar widget="dxButton" toolbar="bottom" location="after" :options="closeOptions" />
      <div>
        <div class="form">
          <div class="dx-fieldset">
            <div class="dx-fieldset-header">Tally Sheet (image / pdf)</div>
            <div v-if="fileTaly">
              File Name : <b>{{ fileTaly[4] }}</b>
            </div>
            <div v-else>File not uploaded</div>
            <DxButton hint="Download TalySheet" styling-mode="outlined" icon="download" type="default"
              @click="Download(DataUkur.TalySheet)" v-if="fileTaly" />
          </div>
          <div class="dx-fieldset">
            <div class="dx-fieldset-header">Shape File (zip)</div>
            <div v-if="fileSHP">
              File Name : <b>{{ fileSHP[4] }}</b>
            </div>
            <div v-else>File not uploaded</div>
            <DxButton hint="Download Shapefile" styling-mode="outlined" icon="download" type="default"
              @click="Download(DataUkur.ShapeFile)" v-if="fileSHP" />
          </div>
          <div class="dx-fieldset">
            <div class="dx-fieldset-header">Foto Udara</div>
            <DxTextArea :height="30" :read-only="true" :value="DataUkur.FotoUdara" />
          </div>
          <div class="dx-fieldset">
            <div class="dx-fieldset-header">Peta Kerja (image / pdf)</div>
            <div v-if="fileBAP">
              File Name : <b>{{ fileBAP[4] }}</b>
            </div>
            <div v-else>File not uploaded</div>
            <DxButton hint="Download BAP" styling-mode="outlined" icon="download" type="default"
              @click="Download(DataUkur.FileBAP)" v-if="fileBAP" />
          </div>
          <div class="dx-fieldset">
            <div class="dx-fieldset-header">Form Join Check (image / pdf)</div>
            <div v-if="fileJoincek">
              File Name : <b>{{ fileJoincek[4] }}</b>
            </div>
            <div v-else>File not uploaded</div>
            <DxButton hint="Download Join Check" styling-mode="outlined" icon="download" type="default"
              @click="Download(DataUkur.FileJoinCheck)" v-if="fileJoincek" />
          </div>
          <div class="dx-fieldset">
            <div class="dx-fieldset-header">Remarks</div>
            <DxTextArea :height="90" :read-only="true" :value="DataUkur.GPS_DocRemarks" />
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
    const uploadTally = globalConfig.backendAPIURL + 'targets/TallySheet/';
    const uploadUkur = globalConfig.backendAPIURL + 'targets/ukur/';
    const uploadSHP = globalConfig.backendAPIURL + 'targets/shp/';
    const uploadBAP = globalConfig.backendAPIURL + 'targets/PetaKerja/';
    const uploadJoincek = globalConfig.backendAPIURL + 'targets/JoinCheck/';
    const fileTaly = '';
    const fileSHP = '';
    const fileUkur = '';
    const fileBAP = '';
    const fileJoincek = '';
    const popupVisible = false;
    const DataUkur = {};
    const fileAdded = false;
    const Grid = {};
    const store = new CustomStore({
      key: 'ID',
      load: function () {
        return CrudService.getAll('targets/region');
      },
      update: (key, values) => {
        if (this.fileAdded) {
          alert(
            'Update Failed, Please finish all your upload before you can save the data',
            'Error'
          );
          return false;
        } else {
          return CrudService.updateData('targets/update/gps', key, values);
        }
      },
    });
    return {
      dataSource: store,
      Access,
      VAccess,
      header,
      uploadTally,
      uploadUkur,
      uploadSHP,
      uploadBAP,
      uploadJoincek,
      fileTaly,
      fileSHP,
      fileUkur,
      fileBAP,
      fileJoincek,
      DataUkur,
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
              return CrudService.updateData('verify', this.DataUkur.ID, {
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
                  return CrudService.updateData('verify', this.DataUkur.ID, {
                    action: 'reject',
                    reason: reason,
                  })
                    .then((response) => {
                      if (!response.status == 'success') {
                        throw new Error(response.message);
                      }
                      
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
          return CrudService.updateData('verify', e.data.ID, {
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
          return CrudService.updateData('verify', e.data.ID, {
            action: 'reupload',
          }).then((response) => {
            if (response.status === 'success')
              alert('Email Reminder sent', 'Information');
          });
        }
      });
    },
    verifyIconClick(e) {
      this.DataUkur = e.data;
      this.fileTaly = e.data.TalySheet ? e.data.TalySheet.split('/') : '';
      this.fileSHP = e.data.ShapeFile ? e.data.ShapeFile.split('/') : '';
      this.fileUkur = e.data.FileUkur ? e.data.FileUkur.split('/') : '';
      this.fileBAP = e.data.FileBAP ? e.data.FileBAP.split('/') : '';
      this.fileJoincek = e.data.FileJoinCheck ? e.data.FileJoinCheck.split('/') : '';
      this.popupVisible = true;
    },
    downloadfile(e) {
      window.open(globalConfig.backendBASEURL + e.value, '_blank');
    },
    deleteFile(e) {
      if (e.columnIndex == 18) this.fileTaly = '';
      if (e.columnIndex == 19) this.fileUkur = '';
      if (e.columnIndex == 20) this.fileSHP = '';
      if (e.columnIndex == 21) this.fileJoincek = '';
      e.setValue('');
    },
    onExporting(e) {
      const workbook = new ExcelJS.Workbook();
      const worksheet = workbook.addWorksheet('Target');

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
      this.uploadTally = globalConfig.backendAPIURL + 'targets/TallySheet/' + e.data.ID;
      this.uploadUkur = globalConfig.backendAPIURL + 'targets/ukur/' + e.data.ID;
      this.uploadSHP = globalConfig.backendAPIURL + 'targets/shp/' + e.data.ID;
      this.uploadBAP = globalConfig.backendAPIURL + 'targets/PetaKerja/' + e.data.ID;
      this.uploadJoincek = globalConfig.backendAPIURL + 'targets/JoinCheck/' + e.data.ID;
      this.fileTaly = e.data.TalySheet ? e.data.TalySheet.split('/') : '';
      this.fileSHP = e.data.ShapeFile ? e.data.ShapeFile.split('/') : '';
      this.fileUkur = e.data.FileUkur ? e.data.FileUkur.split('/') : '';
      this.fileBAP = e.data.FileBAP ? e.data.FileBAP.split('/') : '';
      this.fileJoincek = e.data.FileJoinCheck ? e.data.FileJoinCheck.split('/') : '';
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
      if (e.rowType == 'data' && e.column.dataField == 'Status_GPS') {
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
      if (e.rowType == 'data' && e.column.dataField == 'DAYS_FROM_CPR') {
        if (e.data.DAYS_FROM_CPR <= 5) {
          e.cellElement.style.color = "blue";
        }
        else if (e.data.DAYS_FROM_CPR >= 5) {
          e.cellElement.style.color = "red";
        }

      }
    },
    refreshDataGrid() {
      this.Grid.refresh();
    },
    onInitialized(e) {
      this.Grid = e.component;
    },
    onTalyValueChanged(e) {
      this.fileAdded = true;
      e.component.option('uploadUrl', this.uploadTally);
    },
    onUkurValueChanged(e) {
      this.fileAdded = true;
      e.component.option('uploadUrl', this.uploadUkur);
    },
    onSHPValueChanged(e) {
      this.fileAdded = true;
      e.component.option('uploadUrl', this.uploadSHP);
    },
    onBAPValueChanged(e) {
      this.fileAdded = true;
      e.component.option('uploadUrl', this.uploadBAP);
    },
    onJoincekValueChanged(e) {
      this.fileAdded = true;
      e.component.option('uploadUrl', this.uploadJoincek);
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
    CrudService.findData('accessroles/check', { module: 'TargetGPS' }).then(
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
      module: 'VerifyDocument',
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
<style scoped>
#gridContainer {
  height: 440px;
}
</style>