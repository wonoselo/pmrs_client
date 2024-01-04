<template>
    <div>
        <h5>testing form</h5>
        <input v-model="sector"/>
        <button @click="submit">submit</button>
    </div>
</template>
<script>
import CrudService from '../services/crud.service';
import LocalStorageService from '../LocalStorageService';

const localStorageService = LocalStorageService.getService();

    export default {
        data(){
            const token = localStorageService.getAccessToken();
            const header = { Authorization: 'Bearer ' + token };
            // const sector = null
            return {
                header,
                form:{
                    Sector:'inh',
                    Estate:'a',
                    Featno:123,
                    Kategori:'register',
                    Sitetype:'dry',
                    Landcover:'tes',
                    Replant:'acra',
                    Jenisbelukar:'berat'
                }
            }

        },
        methods :{
            submit(){
                CrudService.store('changecomptadd',this.form)
                .then((res)=>console.log(res))
                .catch((error)=>console.log(error))
                console.log(this.sector)
            }
        }
        
        

    }
</script>