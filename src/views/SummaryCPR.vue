<template>
  <div>
    <panel title="Summary CPR By Sector and Activity">
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
          <DxChart title="CPR Not Yet Measurement GPS" ref="chart">
            <DxTooltip :enabled="true" :customize-tooltip="customizeTooltip" />
            <DxAdaptiveLayout :width="450" />
            <DxSize :height="500" />
            <DxCommonSeriesSettings
              type="bar"
              hover-mode="allArgumentPoints"
              selection-mode="allArgumentPoints"
            />
            <DxCommonAxisSettings discrete-axis-division-mode="crossLabels">
              <DxGrid :visible="true" />
            </DxCommonAxisSettings>
          </DxChart>
          <DxPivotGrid
            id="pivotgrid"
            ref="pivotGridRef"
            :data-source="dataSource"
            :allow-sorting-by-summary="true"
            :allow-filtering="true"
            :show-borders="true"
            :show-column-grand-totals="false"
            :show-row-grand-totals="true"
            :show-row-totals="false"
            :show-column-totals="false"
            @cell-click="onCellClick"
          >
            <DxExport :enabled="true" :allow-export-selected-data="true" />
            <DxFieldChooser :enabled="true" />
            <DxFieldPanel
              :show-column-fields="true"
              :show-data-fields="true"
              :show-filter-fields="true"
              :show-row-fields="true"
              :allow-field-dragging="true"
              :visible="true"
            />
          </DxPivotGrid>
          <DxPopup
            :title="popupTitle"
            :visible="popupVisible"
            @shown="onShown"
            @hiding="onHiding"
          >
            <DxDataGrid
              ref="dataGridRef"
              :data-source="drillDownDataSource"
              :allow-column-resizing="true"
              :show-borders="true"
              :show-column-lines="true"
              :remote-operations="false"
              :row-alternation-enabled="true"
              :column-hiding-enabled="true"
            >
              <DxFilterRow :visible="true" apply-filter="auto" />
              <DxHeaderFilter :visible="true" />
              <DxColumnChooser :enabled="true" />
              <DxExport :enabled="true" :allow-export-selected-data="true" />
              <DxColumnFixing :enabled="false" />
              <DxSearchPanel :visible="true" :highlight-case-sensitive="true" />

              <DxColumn data-field="MAN_ID" width="60" />
              <DxColumn
                data-field="COMP_ID"
                :calculate-cell-value="calculateCellValue"
                width="70"
              />
              <DxColumn data-field="SECTOR" width="60" />
              <DxColumn data-field="ESTATE" width="60" />
              <DxColumn data-field="FEATNO" width="60" />
              <DxColumn data-field="WO_NUMBER" width="100" />
              <DxColumn
                data-field="DAYS_FROM_CPR"
                caption="DAYS FROM CPR"
                width="100"
              />
              <DxColumn data-field="JCOC" width="60" />
              <DxColumn data-field="JCOC_DESC" />
              <DxColumn data-field="CONT_NAME" width="100" />
              <DxColumn
                data-field="REQ_SIZE"
                width="60"
                data-type="number"
                :format="{ type: 'fixedPoint', precision: 1 }"
              />
              <DxColumn
                data-field="REQ_DATE"
                width="80"
                data-type="date"
                format="dd/MM/yyyy"
              />
              <DxColumn
                data-field="FEATSIZE"
                width="80"
                data-type="number"
                :format="{ type: 'fixedPoint', precision: 1 }"
              />
            </DxDataGrid>
          </DxPopup>
        </div>
      </div>
    </panel>
    <DxLoadPanel
      :visible="loadingVisible"
      :show-indicator="true"
      :show-pane="true"
      :shading="true"
      :close-on-outside-click="false"
      shading-color="rgba(0,0,0,0.4)"
    />
  </div>
</template>
<script>
  import {
    DxChart,
    DxAdaptiveLayout,
    DxCommonSeriesSettings,
    DxSize,
    DxTooltip,
    DxCommonAxisSettings,
    DxGrid,
  } from 'devextreme-vue/chart';
  import { DxPopup } from 'devextreme-vue/popup';
  import CrudService from '../services/crud.service';
  import moment from 'moment';
  import {
    DxPivotGrid,
    DxFieldChooser,
    DxFieldPanel,
    DxExport,
  } from 'devextreme-vue/pivot-grid';
  import {
    DxDataGrid,
    DxColumn,
    DxSearchPanel,
    DxColumnChooser,
    DxColumnFixing,
    DxHeaderFilter,
    DxFilterRow,
  } from 'devextreme-vue/data-grid';
  import { DxForm, DxButtonItem } from 'devextreme-vue/form';
  import { DxLoadPanel } from 'devextreme-vue/load-panel';
  export default {
    components: {
      DxChart,
      DxAdaptiveLayout,
      DxCommonSeriesSettings,
      DxCommonAxisSettings,
      DxGrid,
      DxSize,
      DxTooltip,
      DxPivotGrid,
      DxFieldChooser,
      DxFieldPanel,
      DxPopup,
      DxForm,
      DxButtonItem,
      DxDataGrid,
      DxColumn,
      DxExport,
      DxSearchPanel,
      DxColumnChooser,
      DxColumnFixing,
      DxHeaderFilter,
      DxFilterRow,
      DxLoadPanel,
    },
    data() {
      const ds = {};
      var toDay = new Date();
      var isVisible = false;
      var firstDay = new Date(toDay.getFullYear(), toDay.getMonth(), 1);
      const period = { StartDate: firstDay, EndDate: toDay };
      return {
        ds,
        period,
        dataGridRef: 'dataGrid',
        pivotGridRef: 'pivot',
        drillDownDataSource: null,
        popupTitle: '',
        isVisible,
        popupVisible: false,
        loadingVisible: false,
        buttonOptions: {
          text: 'Refresh',
          type: 'success',
          useSubmitBehavior: true,
        },
        dataSource: {
          retrieveFields: false,
          fields: [
            {
              caption: 'Sector',
              width: 50,
              dataField: 'SECTOR',
              area: 'column',
              sortBySummaryField: 'Total',
            },
            {
              caption: 'UoM',
              dataField: 'UoM',
              width: 25,
              area: 'row',
            },
            {
              caption: 'WO count',
              dataField: 'WO_NUMBER',
              dataType: 'number',
              summaryType: 'count',
              area: 'data',
            },
            {
              caption: 'Req Size',
              dataField: 'REQ_SIZE',
              dataType: 'number',
              summaryType: 'sum',
              format: {
                type: 'fixedPoint',
                precision: 1,
              },
              area: 'data',
            },
          ],
          store: ds,
        },
        customizeTooltip(args) {
          var valueText =
            args.seriesName.indexOf('Req') != -1
              ? new Intl.NumberFormat('en-EN', {
                  maximumFractionDigits: 1,
                }).format(args.originalValue)
              : args.originalValue;

          return {
            html: `${args.seriesName}<div class='currency'>${valueText}</div>`,
          };
        },
      };
    },
    mounted() {
      const pivotGrid = this.$refs.pivotGridRef.instance;
      const chart = this.$refs.chart.instance;
      pivotGrid.bindChart(chart, {
        alternateDataFields: false,
        dataFieldsDisplayMode: 'splitPanes',
      });
    },
    computed: {
      dataGrid: function () {
        return this.$refs.dataGridRef.instance;
      },
      pivotGridInstance: function () {
        return this.$refs.pivotGridRef.instance;
      },
    },
    methods: {
      calculateCellValue(rowData) {
        return rowData.SECTOR + rowData.FEATNO;
      },
      onCellClick(e) {
        if (e.area == 'data') {
          this.loadingVisible = true;
          var pivotGridDataSource = e.component.getDataSource(),
            rowPathLength = e.cell.rowPath.length,
            sDate = moment(e.cell.columnPath[1]).format('DD/MM/YYYY'),
            rowPathName = e.cell.rowPath[rowPathLength - 1],
            rcolName =
              e.rowFields[0].caption +
              ' : ' +
              e.cell.rowPath[0] +
              (rowPathLength > 1
                ? ', ' + e.rowFields[1].caption + ' : ' + e.cell.rowPath[1]
                : '') +
              (rowPathLength > 2
                ? ', ' + e.rowFields[2].caption + ' : ' + e.cell.rowPath[2]
                : '');
          this.drillDownDataSource =
            pivotGridDataSource.createDrillDownDataSource(e.cell);
          this.popupTitle = `Detail CPR for ${
            (rowPathName ? rcolName : 'Total') + ', CPR Date : ' + sDate
          } `;
          this.popupVisible = true;
          this.loadingVisible = false;
        }
      },
      onShown() {
        this.dataGrid.updateDimensions();
        this.popupVisible = true;
      },
      onHiding() {
        this.popupVisible = false;
      },
      handleSubmit(e) {
        CrudService.getAll('targets/cluster').then((response) => {
          this.ds = response.data;
          this.pivotGridInstance.option('dataSource.store', response.data);
          this.pivotGridInstance
            .getDataSource()
            .field('Year', { visible: this.isVisible, areaIndex: 0 });
          this.pivotGridInstance.getDataSource().reload();
          this.loadingVisible = false;
        });

        e.preventDefault();
      },
    },
  };
</script>
<style>
#pivotgrid {
  margin-top: 20px;
}
.currency {
  text-align: center;
}
</style>
