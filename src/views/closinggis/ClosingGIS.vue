<template>
  <div class="py-12">
    <panel title="Row Data Closing GIS">
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
              data-field="sector"
              data-type="string"
              caption="Sector"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="estate"
              data-type="string"
              caption="Estate"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="featno"
              data-type="string"
              caption="Feat NO"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="old_compcode"
              data-type="string"
              caption="Old Compcode"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="wo_number"
              data-type="string"
              caption="WO Number"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="jcoc"
              data-type="string"
              caption="JC/OC"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="desc"
              data-type="string"
              caption="Desc"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="cont_code"
              data-type="string"
              caption="Cont Code"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="start_date"
              data-type="date"
              format="dd/MM/yyyy"
              caption="Start Date"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="wo_date"
              data-type="date"
              format="dd/MM/yyyy"
              caption="WO Date"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="jcoc_desc"
              data-type="string"
              caption="JC/OC Desc"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="cont_name"
              data-type="string"
              caption="Cont Name"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="pay_type"
              data-type="string"
              caption="Pay Type"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="req_date"
              data-type="date"
              format="dd/MM/yyyy"
              caption="Req Date"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="req_size"
              data-type="string"
              caption="Req Size"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="locked"
              data-type="string"
              caption="Locked"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="locked_date"
              data-type="date"
              format="dd/MM/yyyy"
              caption="Locked Date"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="gps_date"
              data-type="date"
              format="dd/MM/yyyy"
              caption="GPS Date"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="gismap_date"
              data-type="date"
              format="dd/MM/yyyy"
              caption="GISMAP Date"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="featid"
              data-type="string"
              caption="Feat ID"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="land_cover"
              data-type="string"
              caption="Land Cover"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="speciesid"
              data-type="string"
              caption="Species ID"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="rotation"
              data-type="string"
              caption="Rotation"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="type_contractor"
              data-type="string"
              caption="Type Contractor"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="hqa"
              data-type="string"
              caption="HQA"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="rwa"
              data-type="string"
              caption="RWA"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="qa_status"
              data-type="string"
              caption="QA Status"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="planting_year"
              data-type="string"
              caption="Planting Year"
              header-cell-template="template-header"
            />
            <DxColumn
              data-field="replanting"
              data-type="string"
              caption="Replanting"
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
  DxFilterRow
} from 'devextreme-vue/data-grid';
import CustomStore from 'devextreme/data/custom_store';
import { exportDataGrid } from 'devextreme/excel_exporter';
import ExcelJS from 'exceljs';
import saveAs from 'file-saver';
import moment from 'moment';
import CrudService from '../../services/crud.service';
import DxButton from 'devextreme-vue/button';
import globalConfig from '../../config/GlobalConfig.vue';
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
    DxButton
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
          return CrudService.findData('closinggis', {
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
