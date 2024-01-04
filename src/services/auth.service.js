import Swal from 'sweetalert2';
import LocalStorageService from '../LocalStorageService'
import CrudService from './crud.service';
const localStorageService = LocalStorageService.getService();

class AuthService {
	async login(user) {
		const response = await CrudService.findData('login', { username: user.username, password: user.password });
		if (response.token) {
			localStorageService.setToken(response);
			localStorageService.setUser(JSON.stringify(response));
		}
		return response;
	}

	async logout() {
		try {
			await CrudService.findData('logout', { module: 'UserManager' });

			return true;
		} catch (error) {
			Swal.fire({
				icon: 'error',
				title: 'Oops...',
				text: 'Something went wrong!',
				footer: '<a href>Why do I have this issue?</a>'
			})

			return Promise.error();
		}
	}

	register(user) {
		return CrudService.insertData('signup', { username: user.username, email: user.email, password: user.password })
	}
}

export default new AuthService();
