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
              <DxSimpleItem data-field="Kategori" :editor-options="{disabled: true}"/>
              <DxSimpleItem data-field="Sitetype" :editor-options="{disabled: true}"/>
              <DxSimpleItem data-field="Landcover" :editor-options="{disabled: true}"/>
              <DxSimpleItem data-field="Replant" :editor-options="{disabled: true}"/>
              <DxSimpleItem data-field="Jenisbelukar" :editor-options="{disabled: true}"/>

              <!-- <DxGroupItem>
                <DxGroupItem
                  :visible="isHomeAddressVisible"
                  caption="Home Address"
                  name="HomeAddress"
                >
                  <DxSimpleItem data-field="Berita_Acara" :label="{ text: ' ' }"/>
                  
                </DxGroupItem>
              </DxGroupItem> -->
              <!-- <DxSimpleItem data-field="Kategori" /> -->
            <!-- :visible="(this.dataSource.Kategori = 'Register'?false:true)" -->
              <DxGroupItem caption="Berita Acara/Form PCCR" >
                <DxSimpleItem data-field="Berita_Acara" :label="{ text: ' ' }"  />
              </DxGroupItem> 
            

              <DxGroupItem caption="Shapefile (Khusus Register hanya upload Shapefile)">
                <DxSimpleItem data-field="Shapefile" :label="{ text: ' ' }"  />
              </DxGroupItem> 
              <DxGroupItem caption="Lampiran Peta Sebelum" >
                <DxSimpleItem data-field="Lampiran_petabefore" :label="{ text: ' ' }"  />
              </DxGroupItem>
              <DxGroupItem caption="Lampiran Peta Sesudah">
                <DxSimpleItem data-field="Lampiran_petaafter" :label="{ text: ' ' }"  />
              </DxGroupItem>
              <DxGroupItem caption="Remarks">
                <DxSimpleItem :editor-options="{ height: 100 }" editor-type="dxTextArea" data-field="Uploadreg_Remarks" :label="{ text: ' ' }"/>
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
            cell-template="verifyTemplate"
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
            <!-- <DxLookup
              :data-source="kategori"
              value-expr="kategori"
              display-expr="kategori"
            />
          </DxColumn> -->
          <!-- <DxColumn
            :fixed="true"
            :width="125"
            data-field="Kategori"
            caption="Kategori"
            data-type="string"
            header-cell-template="template-header"
          >
            <DxLookup
              :data-source="kategori"
              value-expr="kategori"
              display-expr="kategori"
            />
          </DxColumn> -->
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
            edit-cell-template="editBeritaAcaraTemplate"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Shapefile"
            data-type="string"
            cell-template="DownloadTemplate"
            edit-cell-template="editShapefileTemplate"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Lampiran_petabefore"
            data-type="string"
            caption="Lampiran Peta Sebelum"
            cell-template="DownloadTemplate"
            edit-cell-template="editPetaBeforeTemplate"
            header-cell-template="template-header"
          />
          <DxColumn
            data-field="Lampiran_petaafter"
            data-type="string"
            caption="Lampiran Peta Sesudah"
            cell-template="DownloadTemplate"
            edit-cell-template="editPetaAfterTemplate"
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

          <template #editBeritaAcaraTemplate="{ data }">
            <div>
              <span v-if="fileba"
                >Current file : <b>{{ fileba[4] }}</b></span
              ><br />
              <DxButton
                :cell-data="data"
                hint="Download File"
                styling-mode="outlined"
                icon="download"
                type="default"
                @click="downloadfile(data)"
                v-if="fileba"
                
              />
              <DxButton
                :cell-data="data"
                hint="Delete File"
                styling-mode="outlined"
                icon="remove"
                type="default"
                @click="deleteFile(data)"
                v-if="fileba"
              />
              <DxFileUploader
               :multiple="false"
                accept="image/png,application/pdf,image/jpeg"
                upload-mode="instantly"
                :upload-url="uploadba"
                :upload-headers="header"
                :max-file-size="5242880"
                @value-changed="onBeritaAcaraValueChanged"
                @uploaded="(e) => onUploaded(e, data)"
              />
            </div>
          </template>

          <template #editShapefileTemplate="{ data }">
            <div>
              <span v-if="fileshp"
                >Current file : <b>{{ fileshp[4] }}</b></span
              ><br />
              <DxButton
                :cell-data="data"
                hint="Download File"
                styling-mode="outlined"
                icon="download"
                type="default"
                @click="downloadfile(data)"
                v-if="fileshp"
                
              />
              <DxButton
                :cell-data="data"
                hint="Delete File"
                styling-mode="outlined"
                icon="remove"
                type="default"
                @click="deleteFile(data)"
                v-if="fileshp"
              />
              <DxFileUploader
               :multiple="false"
                accept="image/png,application/pdf,image/jpeg"
                upload-mode="instantly"
                :upload-url="uploadshp"
                :upload-headers="header"
                :max-file-size="5242880"
                @value-changed="onShapefileValueChanged"
                @uploaded="(e) => onUploaded(e, data)"
              />
            </div>
          </template>

          <template #editPetaBeforeTemplate="{ data }">
            <div>
              <span v-if="filepetabefore"
                >Current file : <b>{{ filepetabefore[4] }}</b></span
              ><br />
              <DxButton
                :cell-data="data"
                hint="Download File"
                styling-mode="outlined"
                icon="download"
                type="default"
                @click="downloadfile(data)"
                v-if="filepetabefore"
                
              />
              <DxButton
                :cell-data="data"
                hint="Delete File"
                styling-mode="outlined"
                icon="remove"
                type="default"
                @click="deleteFile(data)"
                v-if="filepetabefore"
              />
              <DxFileUploader
               :multiple="false"
                accept="image/png,application/pdf,image/jpeg"
                upload-mode="instantly"
                :upload-url="uploadpetabefore"
                :upload-headers="header"
                :max-file-size="5242880"
                @value-changed="onPetaBeforeValueChanged"
                @uploaded="(e) => onUploaded(e, data)"
              />
            </div>
          </template>

          <template #editPetaAfterTemplate="{ data }">
            <div>
              <span v-if="filepetaafter"
                >Current file : <b>{{ filepetaafter[4] }}</b></span
              ><br />
              <DxButton
                :cell-data="data"
                hint="Download File"
                styling-mode="outlined"
                icon="download"
                type="default"
                @click="downloadfile(data)"
                v-if="filepetaafter"
                
              />
              <DxButton
                :cell-data="data"
                hint="Delete File"
                styling-mode="outlined"
                icon="remove"
                type="default"
                @click="deleteFile(data)"
                v-if="filepetaafter"
              />
              <DxFileUploader
               :multiple="false"
                accept="image/png,application/pdf,image/jpeg"
                upload-mode="instantly"
                :upload-url="uploadpetaafter"
                :upload-headers="header"
                :max-file-size="5242880"
                @value-changed="onPetaAfterValueChanged"
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
                  (cellData.data.Uploadreg_UploadStatus === '2' ||
                    cellData.data.Uploadreg_UploadStatus === 2) &&
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
                  (cellData.data.Uploadreg_UploadStatus === '1' ||
                    cellData.data.Uploadreg_UploadStatus === 1) &&
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
                  (cellData.data.Uploadreg_UploadStatus === '2' ||
                    cellData.data.Uploadreg_UploadStatus === 2) &&
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
              <div class="dx-fieldset-header">Berita Acara (image / pdf)</div>
              <div v-if="fileba">
                File Name : <b>{{ fileba[4] }}</b>
              </div>
              <div v-else>File not uploaded</div>
              <DxButton
                hint="Download Berita Acara"
                styling-mode="outlined"
                icon="download"
                type="default"
                @click="Download(Data.Berita_Acara)"
                v-if="fileba"
              />
            </div>
          </div>
          <div class="form">
            <div class="dx-fieldset">
              <div class="dx-fieldset-header">Shapefile (image / pdf)</div>
              <div v-if="fileshp">
                File Name : <b>{{ fileshp[4] }}</b>
              </div>
              <div v-else>File not uploaded</div>
              <DxButton
                hint="Download Shapefile"
                styling-mode="outlined"
                icon="download"
                type="default"
                @click="Download(Data.Shapefile)"
                v-if="fileshp"
              />
            </div>
          </div>
          <div class="form">
            <div class="dx-fieldset">
              <div class="dx-fieldset-header">Lampiran Peta Sebelum (image / pdf)</div>
              <div v-if="filepetabefore">
                File Name : <b>{{ filepetabefore[4] }}</b>
              </div>
              <div v-else>File not uploaded</div>
              <DxButton
                hint="Download Previous Map Attachment"
                styling-mode="outlined"
                icon="download"
                type="default"
                @click="Download(Data.Lampiran_petabefore)"
                v-if="filepetabefore"
              />
            </div>
          </div>
          <div class="form">
            <div class="dx-fieldset">
              <div class="dx-fieldset-header">Lampiran Peta Sesudah (image / pdf)</div>
              <div v-if="filepetaafter">
                File Name : <b>{{ filepetaafter[4] }}</b>
              </div>
              <div v-else>File not uploaded</div>
              <DxButton
                hint="Download Map Attachment After"
                styling-mode="outlined"
                icon="download"
                type="default"
                @click="Download(Data.Lampiran_petaafter)"
                v-if="filepetaafter"
              />
            </div>
          </div>
          <div class="dx-fieldset">
            <div class="dx-fieldset-header">Remarks</div>
            <DxTextArea
              :height="90"
              :read-only="true"
              :value="Data.Uploadreg_Remarks"
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
import { DxSimpleItem, DxGroupItem } from 'devextreme-vue/form';
import CrudService from '../services/crud.service';
import LocalStorageService from '../LocalStorageService';
import DxButton from 'devextreme-vue/button';
import globalConfig from '../config/GlobalConfig.vue';
import { alert, confirm } from 'devextreme/ui/dialog';
const localStorageService = LocalStorageService.getService();
// const Kategori = [{ kategori: 'Register' }, { kategori: 'Split' },{ kategori: 'PCCR' }];
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
    const uploadba = globalConfig.backendAPIURL + 'registersplitupload/Berita_Acara/';
    const uploadshp = globalConfig.backendAPIURL + 'registersplitupload/Shapefile';
    const uploadpetabefore = globalConfig.backendAPIURL + 'registersplitupload/Lampiran_petabefore/';
    const uploadpetaafter = globalConfig.backendAPIURL + 'registersplitupload/Lampiran_petaafter/';
    const fileba = '';
    const fileshp = '';
    const filepetabefore = '';
    const filepetaafter = '';
    const popupVisible = false;
    const Data = {};
    const fileAdded = false;
    const Grid = {};
    const isVis = false;
    
    // const Kategori = [{ kategori: 'Register' }, { kategori: 'Split' },{ kategori: 'PCCR' }];
    const storeupload = new CustomStore({
     key :'id',
      load: function () {
          //registersplitupload/indexupload di ambil dari route
        return CrudService.getAll('registersplitupload/indexupload');
      },
      update: (key, values) => {
        if (this.fileAdded) {
          alert(
            'Update Failed, Please finish all your upload before you can save the data',
            'Error'
          );
          return false;
        } else {
          return CrudService.updateData('registersplitupload/update/Upload', key, values);
        }
      },
    });
    return {
      dataSource: storeupload,
      Access,
      VAccess,
      header,
      uploadba,
      uploadshp,
      uploadpetabefore,
      uploadpetaafter,
      fileba,
      fileshp,
      filepetabefore,
      filepetaafter,
      Data,
      popupVisible,
      Grid,
      fileAdded,
      isVis,
      // kategori: Kategori,
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
              return CrudService.updateData('verifyregistersplit', this.Data.id, {
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
                  return CrudService.updateData('verifyregistersplit', this.Data.id, {
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
      setKategori2Value: (columnData, value) => {
        columnData.Kategori = value;
        this.setVis(value !== 'Register');
      },
     
    };
  },

  methods: {
    setVis(vis) {
      this.isVis = vis;
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
          return CrudService.updateData('verifyregistersplit', e.data.id, {
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
          return CrudService.updateData('verifyregistersplit', e.data.id, {
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
      this.fileba = e.data.Berita_Acara ? e.data.Berita_Acara.split('/') : '';
      this.fileshp = e.data.Shapefile ? e.data.Shapefile.split('/') : '';
      this.filepetabefore = e.data.Lampiran_petabefore ? e.data.Lampiran_petabefore.split('/') : '';
      this.filepetaafter = e.data.Lampiran_petaafter ? e.data.Lampiran_petaafter.split('/') : '';
      this.popupVisible = true;
    },
    downloadfile(e) {
      window.open(globalConfig.backendBASEURL + e.value, '_blank');
    },
    deleteFile(e) {
      if (e.columnIndex == 16) this.fileba = '';
      if (e.columnIndex == 17) this.fileshp = '';
      if (e.columnIndex == 18) this.filepetabefore = '';
      if (e.columnIndex == 19) this.filepetaafter = '';
      e.setValue('');
    },
    onExporting(e) {
      const workbook = new ExcelJS.Workbook();
      const worksheet = workbook.addWorksheet('registersplitupload');

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
      this.uploadba = globalConfig.backendAPIURL + 'registersplitupload/Berita_Acara/' + e.data.id;
      this.uploadshp = globalConfig.backendAPIURL + 'registersplitupload/Shapefile/' + e.data.id;
      this.uploadpetabefore = globalConfig.backendAPIURL + 'registersplitupload/Lampiran_petabefore/' + e.data.id;
      this.uploadpetaafter = globalConfig.backendAPIURL + 'registersplitupload/Lampiran_petaafter/' + e.data.id;
      this.fileba = e.data.Berita_Acara ? e.data.Berita_Acara.split('/') : '';
      this.fileshp = e.data.Shapefile ? e.data.Shapefile.split('/') : '';
      this.filepetabefore = e.data.Lampiran_petabefore ? e.data.Lampiran_petabefore.split('/') : '';
      this.filepetaafter = e.data.Lampiran_petaafter ? e.data.Lampiran_petaafter.split('/') : '';
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
          e.data.Uploadreg_UploadStatus === 3 ||
          e.data.Uploadreg_UploadStatus === '3' ||
          e.data.Uploadreg_UploadStatus === '2' ||
          e.data.Uploadreg_UploadStatus === 2
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
    onBeritaAcaraValueChanged(e) {
      this.fileAdded = true;
      e.component.option('uploadUrl', this.uploadba);
    },
    onShapefileValueChanged(e) {
      this.fileAdded = true;
      e.component.option('uploadUrl', this.uploadshp);
    },
    onPetaBeforeValueChanged(e) {
      this.fileAdded = true;
      e.component.option('uploadUrl', this.uploadpetabefore);
    },
    onPetaAfterValueChanged(e) {
      this.fileAdded = true;
      e.component.option('uploadUrl', this.uploadpetaafter);
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
    CrudService.findData('accessroles/check', { module: 'Registersplitupload' }).then(
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
      module: 'VerifyRegistersplit',
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
