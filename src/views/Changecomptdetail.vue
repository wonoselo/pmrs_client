<template>
    <div class="py-12">
        <panel title="Tes form Upload">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="long-title"><h3> Form Input</h3></div>
                <div id="form-container">
                  <input v-model="forminput.sector"/>

                  <button type="button" @click="changesubmit">submit</button>
                <!-- <DxForm
                
                    :col-count="2"
                    :data-source="dataSource"
                    
                >
                    <DxItem 
                    data-field="Sector"
                    />
                    <DxItem
                    data-field="Estate"
                    />
                    <DxItem
                    data-field="Featno"
                    />
                    <DxItem
                    data-field="Kategori"
                    />
                    <DxItem
                    data-field="Sitetype"               
                    />
                    <DxItem
                    data-field="Landcover"
                    /> -->
                    <!-- <DxItem
                    :col-span="2"
                    :editor-options="{height: 90}"
                    data-field="Notes"
                    editor-type="dxTextArea"
                    /> -->
                    <!-- <DxItem
                    data-field="Replant"
                    />
                    <DxItem
                    data-field="Jenisbelukar"
                    />
                    <DxButtonItem
                        :button-options="buttonOptions"
                        horizontal-alignment="left"
                    />
                    <DxButtonItem
                        :button-options="submitOptions"
                        
                        horizontal-alignment="right"
                    />
                </DxForm> -->

                </div>
            </div>
        </panel>
    </div>
</template>
<script>
// import { DxItem } from 'devextreme-vue/form';
import CrudService from '../services/crud.service';
import 'devextreme-vue/text-area';
import LocalStorageService from '../LocalStorageService';
import CustomStore from 'devextreme/data/custom_store';
const localStorageService = LocalStorageService.getService();

export default {
  components: {
    // DxItem,
  },
  props: ['data', 'flash'],
  data() {
    const token = localStorageService.getAccessToken();
    const header = { Authorization: 'Bearer ' + token };
    const Data = {};
    // const formInput = {
    //   sector,
    // };
    const store = new CustomStore({
      key: 'id',
      load: function () {
        return CrudService.getAll('changecompt/index');
      },
      insert: ( values) => {
        return CrudService.insertData('changecomptadd', values);
      },
      
    });

    return {
        dataSource: store,
        header,
        Data,
        // formInput,
        validationRules: {
            position: [
            { type: 'required', message: 'Position is required.' },
            ],
            hireDate: [
            { type: 'required', message: 'Hire Date is required.' },
            ],
        },
        buttonOptions: {
        text: 'Back',
        type: 'danger',
            onClick: this.changeback.bind(this),
        },
        submitOptions: {
        text: 'Submit',
        type: 'success',
            // onClick: this.changesubmit.bind(this),
            onClick: ()=>console.log('klik form'),
            useSubmitBehavior: true
            
        },
    };
  },
  methods: {
    // changesubmit() {
    //     console.log($this.formInput)
    //     // CrudService.insertData('changecomptadd').then(response => {

    //         // this.formInput = response.data;

    //         // this.Data = this.formInput;
    //     // }
    //     // );
    //     // this.post('changecomptadd',this.formInput).then(Response =>(this.$router.push({name : 'Sector'})))
    //     // .catch(err=> console.log(err))
    //     // .finally(()=> this.loading=false)
         
    // },

    changeback() {
      this.$router.push('/Changecompt')
    },
 
  },
};
</script>
<style scoped>
#form-container {
  margin: 10px 10px 30px;
}

.long-title h3 {
  font-family:
    'Segoe UI Light',
    'Helvetica Neue Light',
    'Segoe UI',
    'Helvetica Neue',
    'Trebuchet MS',
    Verdana;
  font-weight: 200;
  font-size: 28px;
  text-align: center;
  margin-bottom: 20px;
}
</style>
