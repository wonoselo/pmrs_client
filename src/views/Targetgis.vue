<template>
  <div class="py-12">
    <panel title="Target Validaton GIS HO">
      <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
        <DxDataGrid
          :data-source="dataSource"
          @editing-start="onEditingStart"
          @cell-prepared="onCellPrepared"
          @toolbar-preparing="onToolbarPreparing($event)"
          :allow-column-resizing="true"
          :ref="dataGridRef"
          :initialized="onInitialized"
          :show-borders="true"
          :show-column-lines="true"
          column-resizing-mode="widget"
          :column-auto-width="true"
          :remote-operations="false"
          :row-alternation-enabled="true"
          :column-hiding-enabled="false"
        >
          <DxEditing
            :allow-updating="Access.AllowEdit"
            :allow-adding="false"
            :allow-deleting="false"
            :use-icons="true"
            mode="popup"
          >
            <DxPopup
              :width="600"
              :show-title="true"
              title="Upload Peta Validasi"
            >
              <DxPosition my="top" at="top" of="window" />
            </DxPopup>
            <DxForm :col-count="1" :show-colon-after-label="false">
              <DxGroupItem caption="Peta Validasi (image / pdf)">
                <DxSimpleItem
                  data-field="FinalMapFile"
                  :label="{ text: ' ' }"
                />
              </DxGroupItem>
              <DxGroupItem caption="Remarks">
                <DxSimpleItem
                  :editor-options="{ height: 100 }"
                  editor-type="dxTextArea"
                  data-field="FinalMapRemarks"
                  :label="{ text: ' ' }"
                />
              </DxGroupItem>
            </DxForm>
          </DxEditing>
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
            :width="40"
            :allow-grouping="false"
            :allow-filtering="false"
            :allow-editing="false"
            :fixed="true"
            fixed-position="left"
            :allow-fixing="false"
            data-field="id"
            caption="Act"
            header-cell-template="template-header"
            cell-template="verifyTemplate"
          />
          <DxColumn
            data-field="COMP_ID"
            :fixed="true"
            fixed-position="left"
            :allow-fixing="false"
            :calculate-cell-value="calculateCellValue"
            width="70"
            header-cell-template="template-header"
          />
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
            data-type="string"
            :width="50"
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
            data-field="PAYMENT_NO"
            data-type="number"
            :width="70"
            header-cell-template="template-header"
            caption="Pay No"
          />
          <DxColumn
            data-field="PAY_TYPE"
            data-type="string"
            :width="80"
            header-cell-template="template-header"
            caption="PayType"
          />
          <DxColumn
            data-field="JCOC_DESC"
            data-type="string"
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
            data-field="CPR_TO_UPLOAD"
            data-type="string"
            :width="125"
            header-cell-template="template-header"
            caption="CPR to Upload"
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
            data-field="FinalMapDate"
            data-type="datetime"
            format="dd/MM/yyyy H:m"
            :width="115"
            header-cell-template="template-header"
            caption="FinalMap Date"
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
            data-field="FinalMapStatus"
            data-type="string"
            :width="120"
            cell-template="status-cell-template"
            header-cell-template="template-header"
            caption="FinalMap Status"
          />
          <DxColumn
            data-field="FinalMapRemarks"
            data-type="string"
            :width="120"
            header-cell-template="template-header"
            caption="FinalMap Remarks"
          />
          <DxColumn
            data-field="MapReuploadRemarks"
            data-type="string"
            :width="120"
            header-cell-template="template-header"
            caption="MapReupload Remarks"
          />
          <DxColumn
            data-field="GPS_DATE"
            data-type="date"
            format="dd/MM/yyyy"
            :width="85"
            header-cell-template="template-header"
            caption="GPS Date"
          />
          <DxColumn
            data-field="GIS_UPDATE"
            data-type="string"
            :width="55"
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
            data-field="QS_DATE"
            data-type="date"
            format="dd/MM/yyyy"
            :width="80"
            header-cell-template="template-header"
            caption="QS Date"
          />
          <DxColumn
            data-field="QC_DATE"
            data-type="date"
            format="dd/MM/yyyy"
            :width="80"
            header-cell-template="template-header"
            caption="QC Date"
          />
          <DxColumn
            data-field="CONT_CODE"
            data-type="string"
            :width="95"
            header-cell-template="template-header"
            caption="Cont Code"
          />
          <DxColumn
            data-field="CONT_NAME"
            data-type="string"
            :width="125"
            header-cell-template="template-header"
            caption="Contractor"
          />
          <DxColumn
            data-field="FOREMAN_NAME"
            data-type="string"
            :width="125"
            header-cell-template="template-header"
            caption="Mandor"
          />
          <DxColumn
            data-field="SPV_NAME"
            data-type="string"
            :width="125"
            header-cell-template="template-header"
            caption="Assistant"
          />
          <!-- <DxColumn
				data-field="SeedID"
				data-type="string"
				caption="SeedID"
                :width="125"
				header-cell-template="template-header"
				/>
				<DxColumn
				data-field="Species"
				data-type="string"
				caption="Species"
                :width="125"
				header-cell-template="template-header"
				/> -->
          <DxColumn
            data-field="TalySheet"
            :width="90"
            data-type="string"
            cell-template="talyTemplate"
            header-cell-template="template-header"
          />
          <!-- <DxColumn
				data-field="FileUkur"
				:width="90"
				caption="File Data Ukur"
				data-type="string"
				cell-template="talyTemplate"
				header-cell-template="template-header"
				/> -->
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
            :width="90"
            caption="Peta Validasi"
            data-type="string"
            cell-template="talyTemplate"
            edit-cell-template="editFinalMapTemplate"
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
          <template #editFinalMapTemplate="{ data }">
            <div>
              <span v-if="fileFinalMap"
                >Current file : <b>{{ fileFinalMap[4] }}</b></span
              ><br />
              <DxButton
                :cell-data="data"
                hint="Download File"
                styling-mode="outlined"
                icon="download"
                type="default"
                @click="downloadfile(data)"
                v-if="fileFinalMap"
              />
              <DxFileUploader
                :multiple="false"
                accept="image/png,application/pdf,image/jpeg"
                upload-mode="instantly"
                :upload-url="uploadFinalMap"
                :upload-headers="header"
                :max-file-size="5242880"
                @value-changed="onFinalMapValueChanged"
                @uploaded="(e) => onUploaded(e, data)"
              />
            </div>
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
          <template #verifyTemplate="{ data: cellData }">
            <div>
              <DxButton
                :cell-data="cellData"
                :visible="
                  (cellData.data.FinalMapStatus === '2' ||
                    cellData.data.FinalMapStatus === 2) &&
                  VAccess.AllowEdit
                "
                hint="Verify Final Map"
                styling-mode="outlined"
                icon="check"
                type="default"
                @click="verifyIconClick(cellData)"
              />
              <DxButton
                :cell-data="cellData"
                :visible="
                  (cellData.data.FinalMapStatus === '1' ||
                    cellData.data.FinalMapStatus === 1) &&
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
                  (cellData.data.FinalMapStatus === '2' ||
                    cellData.data.FinalMapStatus === 2) &&
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
      :height="400"
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
            <div class="dx-fieldset-header">Peta Validasi (image / pdf)</div>
            <div v-if="fileFinalMap">
              File Name : <b>{{ fileFinalMap[4] }}</b>
            </div>
            <div v-else>File not uploaded</div>
            <DxButton
              hint="Download Final Map"
              styling-mode="outlined"
              icon="download"
              type="default"
              @click="Download(DataUkur.FinalMapFile)"
              v-if="fileFinalMap"
            />
          </div>
          <div class="dx-fieldset">
            <div class="dx-fieldset-header">Remarks</div>
            <DxTextArea
              :height="90"
              :read-only="true"
              :value="DataUkur.FinalMapRemarks"
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
import {
  DxPopup as MyPopup,
  DxPosition as MyPosition,
  DxToolbarItem as MyToolbar,
} from 'devextreme-vue/popup';
const dataGridRef = 'data-grid';
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
    const uploadFinalMap = globalConfig.backendAPIURL + 'targets/finalmap/';
    const fileFinalMap = '';
    const popupVisible = false;
    const DataUkur = {};
    const btnSave = {};
    const fileAdded = false;
    const store = new CustomStore({
      key: 'ID',
      load: function () {
        return CrudService.getAll('targets/gis');
      },
      update: (key, values) => {
        if (this.fileAdded) {
          alert(
            'Update Failed, Please finish all your upload before you can save the data',
            'Error'
          );
          return false;
        } else {
          return CrudService.updateData('targets/update/gis', key, values);
        }
      },
    });
    return {
      dataSource: store,
      Access,
      VAccess,
      header,
      uploadFinalMap,
      fileFinalMap,
      DataUkur,
      dataGridRef,
      popupVisible,
      fileAdded,
      btnSave,
      verifyOptions: {
        icon: 'check',
        type: 'success',
        text: 'Verify Map',
        onClick: () => {
          let result = confirm(
            '<i>Are you sure to verify?</i>',
            'Confirm changes'
          );
          result.then((dialogResult) => {
            if (dialogResult) {
              this.popupVisible = false;
              return CrudService.updateData('verifymap', this.DataUkur.ID, {
                action: 'verify',
              }).then(() => {
                this.DataGrid.refresh();
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
                  return CrudService.updateData('verifymap', this.DataUkur.ID, {
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
                  this.DataGrid.refresh();
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
      return rowData.SECTOR + rowData.FEATNO;
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
          return CrudService.updateData('verifymap', e.data.ID, {
            action: 'reminder',
          }).then(() => {
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
          return CrudService.updateData('verifymap', e.data.ID, {
            action: 'reupload',
          }).then(() => {
            alert('Email Reminder sent', 'Information');
          });
        }
      });
    },
    verifyIconClick(e) {
      this.DataUkur = e.data;
      this.fileFinalMap = e.data.FinalMapFile
        ? e.data.FinalMapFile.split('/')
        : '';
      this.popupVisible = true;
    },
    downloadfile(e) {
      window.open(globalConfig.backendBASEURL + e.value, '_blank');
    },
    deleteFile(e) {
      if (e.columnIndex == 18) this.fileFinalMap = '';
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
      this.uploadFinalMap =
        globalConfig.backendAPIURL + 'targets/finalmap/' + e.data.ID;
      this.fileFinalMap = e.data.FinalMapFile
        ? e.data.FinalMapFile.split('/')
        : '';
    },
    // onCellPrepared(e) {
    //   if (e.column.index == 0 && e.rowType == 'data') {
    //     if (
    //       e.data.FinalMapStatus === 3 ||
    //       e.data.FinalMapStatus === '3' ||
    //       e.data.FinalMapStatus === '2' ||
    //       e.data.FinalMapStatus === 2
    //     ) {
    //       e.cellElement.innerHTML = '';
    //     }
    //   }
    // },
    onCellPrepared(e) {
      // action upload di column
      if (e.column.index == 0 && e.rowType == 'data') {
        if (
          e.data.FinalMapStatus === 3 ||
          e.data.FinalMapStatus === '3' ||
          e.data.FinalMapStatus === '2' ||
          e.data.FinalMapStatus === 2
        ) {
          e.cellElement.innerHTML = '';
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

    onInitialized(e) {
      this.DataGrid = e.components;
    },
    refreshDataGrid() {
      this.DataGrid.refresh();
    },
    onFinalMapValueChanged(e) {
      this.fileAdded = true;
      e.component.option('uploadFinalMap', this.uploadFinalMap);
    },
    onUploaded(e, cellInfo) {
      var data = JSON.parse(e.request.responseText);
      if (data.status == 'success') {
        this.fileAdded = false;
        cellInfo.setValue(data.path);
      } else {
        alert(data.message);
      }
    },
  },
  computed: {
    DataGrid: function () {
      return this.$refs[dataGridRef].instance;
    },
  },
  created() {
    CrudService.findData('accessroles/check', { module: 'TargetGIS' }).then(
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
    CrudService.findData('accessroles/check', { module: 'VerifyMap' }).then(
      (response) => {
        this.VAccess = response.data;
        if (response.isadmin)
          this.VAccess = {
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