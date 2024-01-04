<template>
	<div>
		<ol class="breadcrumb pull-right">
			<li class="breadcrumb-item active"><i class="fa fa-tachometer-alt"></i> Dashboard</li>
		</ol>
		<h1 class="page-header">
			Welcome <small>Planning Monitoring & Reporting System</small>
		</h1>
		<div class="row row-space-10 m-b-20">
			<!-- begin col-4 -->
			<div class="col-lg-12 col-md-12">
				<div class="widget widget-stats bg-gradient-white m-b-10">
					<div class="stats-icon stats-icon-lg"><i class="fa fa-chart-line fa-fw"></i></div>
					<div class="stats-content">
						<DxChart
						id="chart1"
						:data-source="getBySector('FNH')"
						default-pane="bottomPane"
						title="CPR Trend FNH"
						>
							<DxTitle
							text="CPR Trend FNH"
							:subtitle="chSubtitle"
							/>
							<DxTooltip
							:enabled="true"
							:customize-tooltip="customizeTooltip"
							/>
							<DxCommonSeriesSettings argument-field="REQ_DATE"/>
							<DxCommonAxisSettings discrete-axis-division-mode= "crossLabels">
								<DxGrid :visible="true"/>
							</DxCommonAxisSettings>
							<DxSeries
							pane="topPane"
							type="spline"
							value-field="WOCount"
							name="WO Count"
							>
							</DxSeries>
							<DxSeries
							type="spline"
							value-field="ReqSize"
							name="Req Size"
							>
							</DxSeries>

							<DxPane name="topPane"/>
							<DxPane name="bottomPane"/>
							<DxArgumentAxis
							argument-type="datetime"
							title="CPR Date"
							tick-interval="day"
							/>
							<DxValueAxis pane="bottomPane">
								<DxGrid :visible="true"/>
								<DxTitle text="Req Size"/>
							</DxValueAxis>
							<DxValueAxis pane="topPane">
								<DxGrid :visible="true"/>
								<DxTitle text="WO Count"/>
							</DxValueAxis>

							<DxLegend
							vertical-alignment="bottom"
							horizontal-alignment="center"
							/>
							<DxExport :enabled="true"/>
						</DxChart>
					</div>
				</div>
			</div>
			<!-- end col-4 -->
			<!-- Land Dispute -->
			<div class="col-lg-12 col-md-12">
				<div class="widget widget-stats bg-gradient-white m-b-10">
					<div class="stats-icon stats-icon-lg"><i class="fa fa-chart-line fa-fw"></i></div>
					<div class="stats-content">
						<DxChart id="chart2" :data-source="getByProgres('FNH')" default-pane="bottomPane">
							<DxTitle text="Trend Land Dispute" :subtitle="chSubtitle2"/>
							<DxTooltip :enabled="true" :customize-tooltip="customizeTooltipld"/>
							<DxCommonSeriesSettings argument-field="Req_Upload_Date"/>
							<DxCommonAxisSettings discrete-axis-division-mode= "crossLabels">
								<DxGrid :visible="true"/>
							</DxCommonAxisSettings>
							<!-- chart -->
							<DxSeries type="bar" :data-source="getByPHBM('PHBM')" name="Claimer"></DxSeries>
							<DxSeries type="bar" value-field="Pola" name="tes"></DxSeries>
							<DxSeries type="bar" value-field="Pola" name="tes2"></DxSeries>
							<!-- <DxSeries type="bar" value-field="Pola" name="Pola"></DxSeries> -->
							<DxPane name="topPane"/>
							<DxPane name="bottomPane"/>
							<DxArgumentAxis argument-type="Pola" title="Land Dispute" />
							<!-- <DxValueAxis pane="bottomPane">
								<DxGrid :visible="true"/>
								<DxTitle text="Status"/>
							</DxValueAxis> -->
							<DxValueAxis pane="topPane">
								<DxGrid :visible="true"/>
								<DxTitle text="Pola"/>
							</DxValueAxis>
							<DxLegend vertical-alignment="bottom" horizontal-alignment="center"/>
							<DxExport :enabled="true"/>
						</DxChart>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>
<script>
import DxChart, {
	DxCommonSeriesSettings,
	DxSeries,
	DxPane,
	DxValueAxis,
	DxCommonAxisSettings,
	DxExport,
	DxLegend,
	DxTitle,
	DxGrid,
	DxTooltip,
	DxArgumentAxis
} from 'devextreme-vue/chart';
import CrudService from '../services/crud.service';
import moment from 'moment'
export default {
	components: {
		DxChart,
		DxCommonSeriesSettings,
		DxSeries,
		DxPane,
		DxValueAxis,
		DxCommonAxisSettings,
		DxExport,
		DxLegend,
		DxTitle,
		DxGrid,
		DxTooltip,
		DxArgumentAxis
	},
	data() {
		var toDay = new Date();
        var firstDay = new Date(toDay.getFullYear(), toDay.getMonth(), 1); 
		const period = { StartDate : firstDay, EndDate : toDay}
		
		var toDay2 = new Date();
        var firstDay2 = new Date(toDay.getFullYear(),-15); 
		const period2 = { StartDate2 : firstDay2, EndDate2 : toDay2}
		var cprData = []
		var landData = []
		var chSubtitle = "Period :"+ moment(firstDay).format('DD/MM/YYYY')+" - "+ moment(toDay).format('DD/MM/YYYY')
		var chSubtitle2 = "Period :"+ moment(firstDay2).format('DD/MM/YYYY')+" - "+ moment(toDay2).format('DD/MM/YYYY')
		return {
			cprData,
			landData,
			period,
			period2,
			chSubtitle,
			chSubtitle2,
            customizeTooltip(args) {
                var valueText = (args.seriesName.indexOf('Req') != -1)
                ? new Intl.NumberFormat('en-EN', {maximumFractionDigits:1}).format(args.originalValue)
                : args.originalValue;
                return {
                    html: `${ moment(args.argument).format('MMM-DD') } :<b> ${ valueText }</b>`
                };
            },
			customizeTooltipld(args) {
                var valueText = (args.seriesName.indexOf('Req') != -1)
                ? new Intl.NumberFormat('en-EN', {maximumFractionDigits:1}).format(args.originalValue)
                : args.originalValue;
                return {
                    html: `${ moment(args.argument).format('MMM-DD') } :<b> ${ valueText }</b>`
                };
            }
		}
	},
	methods: {
		getBySector(fu){	
			if (this.cprData){
				return  this.cprData.filter(function(data){
					return data.MAN_ID === fu;
				});
			}else{
				return []
			}	
			
		},
		getByProgres(ld){	
			if (this.landData){
				return  this.landData.filter(function(data){
					return data.MAN_ID === ld;
				});
			}else{
				return []
			}	
			
		},
		getByPHBM(ld){	
			if (this.landData){
				return  this.landData.filter(function(data){
					return data.Pola === ld;
				});
			}else{
				return []
			}	
			
		},
		woCustomizeText({ valueText }) {
			return `${valueText}`;
		},

		areaCustomizeText({ valueText }) {
			return `${valueText} ha`;
		}
	},	
	created(){
		var startDate = moment(this.period.StartDate).format('YYYY-MM-DD')
		var endDate = moment(this.period.EndDate).format('YYYY-MM-DD')
		CrudService.findData('dashboard/cpr',{startDate:startDate, endDate : endDate}).then(response => {
			this.cprData = response.data
		});	
		var startDate2 = moment(this.period2.StartDate2).format('YYYY-MM-DD')
		var endDate2 = moment(this.period2.EndDate2).format('YYYY-MM-DD')
		CrudService.findData('dashboard/land',{startDate2:startDate2, endDate2 : endDate2}).then(response => {
			this.landData = response.data
		});	
		
	},
	
}
</script>