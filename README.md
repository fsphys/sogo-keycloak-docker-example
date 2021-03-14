# Setup

1. Clone the repo
2. Generate passwords with `./gen_passwords`
3. Start all services using `docker-compose up`
4. Go to `http://localhost:9090/keycloak/auth/admin/` and login as `admin` with the password from `.env`
5. Add a new realm by importing `test-realm.json`
6. Add a user at `http://localhost:9090/keycloak/auth/admin/master/console/#/create/user/test` and set a password in Cerdentials
7. Go to `http://localhost:9090/SOGo/` and login as that user
