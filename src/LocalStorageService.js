const LocalStorageService = (function(){
 var _service;
 function _getService() {
     if(!_service) {
       _service = this;
       return _service
   }
   return _service
 }
 function _setToken(tokenObj) {
   localStorage.setItem('access_token', tokenObj.token);
   localStorage.setItem('refresh_token', tokenObj.refresh_token);
 }

  function _setUser(user) {
   localStorage.setItem('user', user);
 }
 function _getAccessToken() {
   return localStorage.getItem('access_token');
 }
 function _getUser() {
   return localStorage.getItem('user');
 }
 function _getRefreshToken() {
   return localStorage.getItem('refresh_token');
 }
 function _clearToken() {
   localStorage.removeItem('access_token');
   localStorage.removeItem('user');
   localStorage.removeItem('refresh_token');
 }
return {
   getService : _getService,
   setToken : _setToken,
   setUser : _setUser,
   getAccessToken : _getAccessToken,
   getUser : _getUser,
   getRefreshToken : _getRefreshToken,
   clearToken : _clearToken
 }
})();
export default LocalStorageService;