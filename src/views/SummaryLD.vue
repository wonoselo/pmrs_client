<template>
  <div>
    <panel title="Summary Land Dispute">
      <div class="card bg-light border-0 text-white">
        <div class="card-body">
          <form
            action="#"
            @submit="handleSubmit">
            <DxForm
              :form-data="period"
              :read-only="false"
              col-count=2
              :show-colon-after-label="true"
              :show-validation-summary="true">
              <DxSimpleItem
                data-field="StartDate"
                :editor-options ="{type:'date', displayFormat:'dd/MM/yyyy'}"
                editor-type="dxDateBox"
              />
              <DxSimpleItem
                data-field="EndDate"
                editor-type="dxDateBox"
                :editor-options ="{type:'date', displayFormat:'dd/MM/yyyy'}"
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
          <DxChart 
            title="Summary Land Dispute"
            ref="chart">
            <DxTooltip
              :enabled="true"
              :customize-tooltip="customizeTooltip"
            />
            <!-- <DxAdaptiveLayout :width="450"/> -->
            <DxSize :height="500"/>
            <DxCommonSeriesSettings type="bar"/>
            <DxCommonAxisSettings discrete-axis-division-mode= "crossLabels">
              <DxGrid :visible="true"/>
            </DxCommonAxisSettings>
          </DxChart>
          <DxPivotGrid
            id="pivotgrid"
            ref="pivotGridRef" 
            :data-source="dataSource"
            :allow-sorting-by-summary="true"
            :allow-filtering="true"
            :show-borders="true"
            :show-column-grand-totals="true"
            :show-row-grand-totals="true"
            :show-row-totals="true"
            :show-column-totals="false"
            @cell-click="onCellClick">
            <DxFieldChooser :enabled="true"/>
            <DxExport :enabled="true" :allow-export-selected-data="true"/>
            <DxFieldPanel
              :show-column-fields="true"
              :show-data-fields="false"
              :show-filter-fields="true"
              :show-row-fields="true"
              :allow-field-dragging="true"
              :visible="true"
            />
          </DxPivotGrid>
          <DxPopup
            :title="popupTitle"
            :visible="popupVisible"
            :width="1200"
            :height="800"
            @shown="onShown"
            @hiding="onHiding">
            <!-- DATA GRID -->
            <DxDataGrid
              ref="dataGridRef"
              :data-source="drillDownDataSource"
              :show-borders="true"
              :show-column-lines="true"        
              :row-alternation-enabled="true"                      
              >
              <DxPaging :enabled="true"/>
              <DxScrolling column-rendering-mode="virtual"/>
              <DxFilterRow :visible="true" apply-filter="auto"/>
              <DxHeaderFilter :visible="true"/>
              <DxColumnChooser :enabled="false"/>
              <DxExport :enabled="true" :allow-export-selected-data="true"/>
              <DxColumnFixing :enabled="false"/>
              <DxSearchPanel :visible="true" :highlight-case-sensitive="true"/>
              <DxColumn data-field="Sector" width="60"/>
              <!-- <DxColumn data-field="Estate" caption="Est" width="40"/> -->
              <DxColumn data-field="Featno" :calculate-cell-value="calculateCellValue" width="130"/>
              <DxColumn data-field="Pola" width="85"/>
              <DxColumn data-field="Nama_Claimer" />
              <DxColumn data-field="No_KTP_Claimer" width="120"/>  
              <DxColumn data-field="UploadStatus" cell-template="status-cell-template"/>
              <DxColumn data-field="UploadStatusPlan"  caption="Planning Upload Status" cell-template="status-cell-template"/>
              <DxColumn data-field="Statutory_UploadStatus" cell-template="status-cell-template"/>
              <DxColumn data-field="UploadStatus_Submission" caption="Submission Upload Status" cell-template="status-cell-template"/>
              <DxColumn data-field="UploadStatus_Sslho" caption="Payment Upload Status" cell-template="status-cell-template"/>
              <DxColumn data-field="Luas" format="#,####0.## Ha" data-type="number" width="100" />
              <DxColumn data-field="Nominal" caption="Nominal Pembayaran" data-type="number" format="Rp #,##0.##" width="150"/>

              <DxSummary>
                <DxTotalItem
                  column="Featno"
                  summary-type="count"
                />
                <DxTotalItem
                  column="Luas"
                  summary-type="sum"
                  value-format="#,####0.## Ha"
                  data-type="number"
                  type="fixedPoint" 
                  precision="1"
                />
                <DxTotalItem
                  column="Nominal"
                  summary-type="sum"
                  value-format="Rp #,##0.##"
                  data-type="number"
                  
                />
              </DxSummary>
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
            </DxDataGrid>
            <!-- DATA GRID -->
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
    // DxAdaptiveLayout,
    DxCommonSeriesSettings,
    DxSize,
    DxTooltip,
    DxCommonAxisSettings,
    DxGrid,
  } from 'devextreme-vue/chart';
  import { DxPopup } from 'devextreme-vue/popup';
  import CrudService from '../services/crud.service';
  import moment from 'moment'
  import {
    DxPivotGrid,
    DxFieldChooser,
    DxFieldPanel, 
    DxExport,
  } from 'devextreme-vue/pivot-grid';
  import { DxDataGrid, DxColumn,DxSearchPanel, DxColumnChooser, DxColumnFixing, DxHeaderFilter,DxFilterRow,DxSummary,DxTotalItem,DxScrolling } from 'devextreme-vue/data-grid';
  import { DxForm, DxSimpleItem,DxButtonItem } from 'devextreme-vue/form';
  import { DxLoadPanel } from 'devextreme-vue/load-panel';
  export default {
    components: {
      DxScrolling,
      DxSummary,
      DxTotalItem,
      DxChart,
      // DxAdaptiveLayout,
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
      DxSimpleItem,
      DxButtonItem,
      DxDataGrid,
      DxColumn,  
      DxExport,
      DxSearchPanel, 
      DxColumnChooser, 
      DxColumnFixing, 
      DxHeaderFilter,
      DxFilterRow,
      DxLoadPanel
    },
    data() {
      const ds ={}  
      var toDay = new Date();
      var isVisible = false;
      var firstDay = new Date(toDay.getFullYear(), toDay.getMonth(), 1); 
      const period = { StartDate : firstDay, EndDate : toDay}
      return {
        ds,
        period,
        dataGridRef: 'dataGrid',
        pivotGridRef:'pivot',
        drillDownDataSource: null,
        popupTitle: '', 
        isVisible,
        popupVisible: false,
        loadingVisible: false,
        buttonOptions: {
          text: 'Refresh',
          type: 'success',
          useSubmitBehavior: true
        },
        dataSource: {
          retrieveFields:false,
          fields: [{
            dataField: 'Sector',
            width: 150,
            area: 'row'
          },
          //  {
          //   dataField: 'Tahun',
          //   areaIndex: 1,
          //   expanded:true,
          //   area: 'column'
          // },
          //  {
          //   dataField: 'Bulan',
          //   areaIndex: 2,
          //   dataType: 'number',
          //   expanded:true,
          //   area: 'column',
          //    format: {
          //     type: '00',
          //     precision: 1,
          //   },
          // },
          {
            width: 120,
            dataField: 'Pola',
            expanded:true,
            area: 'column',
            areaIndex: 3,
          },{
            caption: 'Req count',
            dataField: 'No_KTP_Claimer',
            dataType: 'number',
            summaryType: 'count',
            area: 'data'
          },{
            caption: 'Req Size',
            dataField: 'Luas',
            dataType: 'number',
            summaryType: 'sum',
            format: {
              type: 'fixedPoint',
              precision: 1
            },
            area: 'data'
          },{
            caption: 'Total',
            dataField: 'Nominal',
            dataType: 'number',         
            summaryType: 'sum',         
            format: {
              type: 'Rp #,##0.##',
              precision: 1,
            },
            area: 'data',
          },{
            dataField: 'Status',
            dataType: 'string',
            area: 'column',
            areaIndex: 4
          }
        
          ],
          store: ds
        },
        customizeTooltip(args) {
          var valueText = (args.seriesName.indexOf('Req') != -1)
          ? new Intl.NumberFormat('en-EN', {maximumFractionDigits:1}).format(args.originalValue)
          : args.originalValue;

          return {
              html: `${args.seriesName }<div class='currency'>${ valueText }</div>`
          };
        }
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
        dataGrid: function() {
          return this.$refs.dataGridRef.instance;
        },
        pivotGridInstance: function() {
          return this.$refs.pivotGridRef.instance;
        }
      },
      methods: {
        calculateCellValue(rowData){  
            return rowData.Estate + rowData.Featno;  
        },
        onCellClick(e) {
          if (e.area == 'data') {
            this.loadingVisible = true;
            var pivotGridDataSource = e.component.getDataSource(),
            rowPathLength = e.cell.rowPath.length,
            sDate = moment(e.cell.columnPath[1]).format('DD/MM/YYYY'),
            rowPathName = e.cell.rowPath[rowPathLength - 1],
            rcolName =e.rowFields[0].caption+' : '+e.cell.rowPath[0]+(rowPathLength>1?', '+e.rowFields[1].caption+' : '+e.cell.rowPath[1]:'')+(rowPathLength>2?', '+e.rowFields[2].caption+' : '+e.cell.rowPath[2]:'');
            this.drillDownDataSource = pivotGridDataSource.createDrillDownDataSource(e.cell);
            this.popupTitle = `Detail Summary for ${ (rowPathName ? rcolName : 'Total')+', Summary Date : '+sDate } ` ;
            this.popupVisible = true;
            this.loadingVisible = false;
          }
        },
        onShown() {
          this.dataGrid.updateDimensions();
          this.popupVisible =true;
        },
        onHiding() {
          this.popupVisible =false;
        },
        handleSubmit(e) {
          var startDate = moment(this.period.StartDate).format('YYYY-MM-DD')
          var endDate = moment(this.period.EndDate).format('YYYY-MM-DD')
          this.isVisible =(moment(startDate).format('YYYY') !== moment(endDate).format('YYYY'))?true:false
          CrudService.findData('summaryld',{startDate:startDate, endDate : endDate}).then(response => {
            this.ds = response.data
            this.pivotGridInstance.option('dataSource.store', response.data);
            this.pivotGridInstance.getDataSource().field("Year", {visible:this.isVisible,areaIndex:0});
            this.pivotGridInstance.getDataSource().reload();
            this.loadingVisible = false;
          });	
          e.preventDefault();
        }
      }
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