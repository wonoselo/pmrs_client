<template>
	<panel title="Profile">
		<div>
			<div class="max-w-7xl mx-auto sm:px-6 lg:px-8 responsive-paddings">
				<DxForm
				id="form"
				label-location="top"
				:read-only="true"
				:form-data="formData"
				:colCountByScreen="colCountByScreen"
				>
					<DxItem data-field="fullname"/>
					<DxItem data-field="username"  />
					<DxItem 
					data-field="role_id"
					data-type="number" 
					:label="{text:'Role'}"
                    :editor-options="{ dataSource: role,valueExpr: 'id', displayExpr:'RoleName'}"
					editor-type="dxSelectBox"
					/>
					<DxItem data-field="email" />
					<DxItem data-field="bu" />
					<DxItem data-field="sector" />
					<DxItem 
					data-field="isAdmin" 
					data-type="boolean"
					editor-type="dxCheckBox"
					/>
					<DxItem 
					data-field="isActivated" 
					data-type="boolean" 
					editor-type="dxCheckBox"
					/>
					<DxItem 
					data-field="lastActive" 
					data-type="date" 
					editor-type="dxDateBox"
					/>
				</DxForm>
			</div>
		</div>
	</panel>
</template>

<script>
import { DxForm, DxItem } from "devextreme-vue/form";
import CrudService from '../services/crud.service';

export default {
  props: {
    picture: String
  },
  data() {
    const formData = {}
    const currentUser = {}
    const colCountByScreen = {
      xs: 1,
      sm: 2,
      md: 3,
      lg: 4
    }
	const role={}
    return {
      role,
      formData,
      currentUser,
      colCountByScreen
    };
  },
  name: 'Profile',

  mounted() {

    CrudService.getAll('profile').then((response) => {
        this.currentUser = response;
        this.formData = this.currentUser.user
      });
  CrudService.getAll('roles').then((response) => {
   this.role= response.data
  });
	
  },
  components: {
    DxForm,DxItem
  }
};
</script>

<style lang="scss">
.form-avatar {
  float: left;
  height: 120px;
  width: 120px;
  margin-right: 20px;
  border: 1px solid rgba(0, 0, 0, 0.1);
  background-size: contain;
  background-repeat: no-repeat;
  background-position: center;
  background-color: #fff;
  overflow: hidden;

  img {
    height: 120px;
    display: block;
    margin: 0 auto;
  }
}
</style>