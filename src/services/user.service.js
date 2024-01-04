import CrudService from './crud.service';
class UserService {
	getPublicContent() {
		return CrudService.getAll('all');
	}
	getUserBoard() {
		return CrudService.getAll('user');
	}
	getModeratorBoard() {
		return CrudService.getAll('mod');
	}
	getAdminBoard() {
		return CrudService.getAll('admin');
	}
}

export default new UserService();
