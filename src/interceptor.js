import router from './router.js';
import axios from 'axios';
import globalConfig from './config/GlobalConfig.vue'
import LocalStorageService from './LocalStorageService'
const localStorageService = LocalStorageService.getService();
const API_URL = globalConfig.backendAPIURL;

axios.interceptors.request.use(
	config => {
		const token = localStorageService.getAccessToken();
		if (token) {
			config.headers['Authorization'] = 'Bearer ' + token;
		}
		return config;
	},
	error => {
		Promise.reject(error)
	});

axios.interceptors.response.use((response) => {
	return response
}, function (error) {
	const originalRequest = error.config;
	if (error.response.status === 401 && (originalRequest.url === API_URL + 'refresh' || originalRequest.url === API_URL + 'login')) {
		history.go('/login')
		return Promise.reject(error);
	}

	if (error.response.status === 401 && !originalRequest._retry) {
		originalRequest._retry = true;
		const refreshToken = localStorageService.getRefreshToken();

		return axios.post(API_URL + 'refresh', { "refresh_token": refreshToken })
			.then(res => {
				if ((res.status === 200) || (res.status === 201)) {
					localStorageService.setToken(res.data);
					axios.defaults.headers.common['Authorization'] = 'Bearer ' + localStorageService.getAccessToken();
					return axios(originalRequest);
				} else {
					localStorageService.clearToken();
					history.go('/login')
					return Promise.reject(error);
				}
			}).catch(() => {
				console.log("kena disni")
				localStorageService.clearToken();
				history.go('/login')
				return Promise.reject(error);
			})
	}
	return Promise.reject(error);
});