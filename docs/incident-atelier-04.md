# Incident atelier 4 : service injoignable
1. Symptôme : la connexion de api vers la base échoue (ConnectionRefusedError [Errno 111] vers localhost:5432).
2. Config effective (exec api env) : DB_HOST=localhost.
3. Attendu : DB_HOST=db. Dans le conteneur api, localhost désigne api lui-même, où rien n'écoute sur 5432.
4. Vérification : getent hosts db + test socket vers db -> OK. Correction : DB_HOST: db, puis up --force-recreate api.
