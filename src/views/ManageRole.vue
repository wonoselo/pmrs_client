<template>
	
	<div class="py-12">
		<panel title="Manage Role">
			<div class="max-w-7xl mx-auto sm:px-6 lg:px-8">	
			<DxDataGrid
			@toolbar-preparing="onToolbarPreparing($event)"
			:ref="dataGridRef"
			:data-source="dataSource"
			:allow-column-resizing="true"
			:show-borders="true"
			:show-column-lines="true"
			:remote-operations="false"
			:row-alternation-enabled="true"
			:column-hiding-enabled="true"
			>
				<DxEditing
				:allow-updating="Access.AllowEdit"
				:allow-adding="Access.AllowAdd"
				:allow-deleting="Access.AllowDelete"
				:use-icons="true"
				mode="cell"
				/>
				<DxColumn
				type="buttons"
				:width="110"
				:fixed="true" 
				fixed-position="left"
				:allow-fixing="false"
				/>
				<DxColumn
				data-field="RoleName"
				data-type="string"
				header-cell-template="template-header"
				/>
				<DxColumn
				data-field="RoleDescription"
				data-type="string"
				header-cell-template="template-header"
				/>
				<DxColumn
				data-field="isActive"
				data-type="boolean"
				header-cell-template="template-header"
				/>
				<DxExport
				:enabled="true"
				:allow-export-selected-data="true"
				/>
				<DxColumnChooser :enabled="true"/>
				<DxColumnFixing :enabled="true"/>
				<DxSearchPanel
				:visible="true"
				:highlight-case-sensitive="true"
				/>
				<DxHeaderFilter
				:visible="true"
				/>
				<DxFilterRow
				:visible="true"
				/>
				<DxPaging :page-size="20"/>
				<DxPager
				:show-page-size-selector="true"
				:allowed-page-sizes="[20, 50, 100]"
				/>
				<template #template-header="{ data }">
					<span style="color: navy;font-weight:bold;font-size:9pt;">{{ data.column.caption }}</span>
				</template>
			</DxDataGrid>
		</div>
		</panel>
	</div>
</template>
<script>
import { DxDataGrid, DxColumn, DxPaging, DxPager, DxEditing, DxExport,DxSearchPanel, DxColumnChooser, DxColumnFixing, DxHeaderFilter,DxFilterRow } from 'devextreme-vue/data-grid';
import CustomStore from 'devextreme/data/custom_store';
import { exportDataGrid } from 'devextreme/excel_exporter';
import ExcelJS from 'exceljs';
import saveAs from 'file-saver';
import CrudService from '../services/crud.service';
const store = new CustomStore({
	key: 'id',
	load: function() {
		return CrudService.getAll('roles');
	},
	insert: (values) => {
		return CrudService.insertData('roles',values);
	},
	remove: (key) => {
		return CrudService.removeData('roles/delete',key);
	},
	update: (key, values) => {
		return CrudService.updateData('roles',key,values);
	}
});
const dataGridRef = "data-grid";
export default {
	components: { DxDataGrid, DxColumn, DxPaging, DxPager, DxEditing, DxSearchPanel,DxExport, DxColumnChooser, DxColumnFixing, DxHeaderFilter,DxFilterRow},
	props: ['data', 'flash'],
	data() {
		const Access = {'AllowView':false, 'AllowAdd':false,'AllowEdit':false,'AllowDelete':false}
		return {
			dataSource: store,
			dataGridRef,
			Access
		};
	}, 
	methods: {
		onExporting(e) {
			const workbook = new ExcelJS.Workbook();
			const worksheet = workbook.addWorksheet('Roles');

			exportDataGrid({
				component: e.component,
				worksheet: worksheet,
				autoFilterEnabled: true
			}).then(() => {
				workbook.xlsx.writeBuffer().then((buffer) => {
					saveAs(new Blob([buffer], { type: 'application/octet-stream' }), 'DataGrid.xlsx');
				});
			});
			e.cancel = true;
		},
		onToolbarPreparing(e) {
			e.toolbarOptions.items.unshift(
			{
				location: 'after',
				widget: 'dxButton',
				options: {
					icon: 'refresh',
					onClick: this.refreshDataGrid.bind(this)
				}
			});
		},
		refreshDataGrid() {
			this.DataGrid.refresh();
		},
	},
	computed: {
		DataGrid: function() {
			return this.$refs[dataGridRef].instance;
		},
		
	},
	
	created() { 
		CrudService.findData('accessroles/check',{ module: 'RoleManager' }).then(response => {
			this.Access = response.data
			if (response.isadmin) this.Access ={'AllowView':true, 'AllowAdd':true,'AllowEdit':true,'AllowDelete':true}
		});
	}
};
</script>