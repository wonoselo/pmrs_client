import axios from 'axios';
import Swal from 'sweetalert2'
import globalConfig from '../config/GlobalConfig.vue'

const Toast = Swal.mixin({
  toast: true,
  position: 'top-end',
  showConfirmButton: false,
  timer: 3000,
  timerProgressBar: true,
  didOpen: (toast) => {
    toast.addEventListener('mouseenter', Swal.stopTimer)
    toast.addEventListener('mouseleave', Swal.resumeTimer)
  }
})

const API_URL = globalConfig.backendAPIURL ;

class CrudService {
	getAll(table){
		return axios.get(API_URL +table).then(response => response.data);
	}
	getByID(table,key){
		return axios.get(API_URL +table+"/"+key).then(response => response.data);
	}
	findData(table,params) {
		return axios.post(API_URL +table,params).then(response => response.data);
	}
	insertData(table,values) {
		return axios.post(API_URL +table,values).then((response) => {  
			Toast.fire({
				icon: 'success',
				title: 'Data created successfully'
			})
			return response.data
		}).catch(() => {
			Swal.fire({
				icon: 'error',
				title: 'Oops...',
				text: 'Something went wrong!',
				footer: '<a href>Why do I have this issue?</a>'
			})
		})
	}
	removeData(table,key){
		return axios.get(API_URL +table+"/"+key).then((response)=> {
			Toast.fire({
				icon: 'success',
				title: 'Data deleted successfully'
			})
			return response.data
		}).catch(() => {
			Swal.fire({
				icon: 'error',
				title: 'Oops...',
				text: 'Something went wrong!',
				footer: '<a href>Why do I have this issue?</a>'
			})
		})
	}
	updateData(table,key,values){
		return axios.post(API_URL +table+"/"+key,values).then((response)=>{
			Toast.fire({
				icon: 'success',
				title: 'Data updated successfully'
			})
			return response.data
		})
		.catch(()=>{
			Swal.fire({
				icon: 'error',
				title: 'Oops...',
				text: 'Something went wrong!',
				footer: '<a href>Why do I have this issue?</a>'
			})
		})
	}
	store(url,form){
		return axios.post(API_URL + url,form)
	}
}


export default new CrudService();
