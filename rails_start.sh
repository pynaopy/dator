# Railsディレクトリへ移動
cd /home/ubuntu/dator/

# gem適用
bundle install

# database.yml mysqlのsocketパスを変更
sed -e "s/\/var\/lib\/mysql\/mysql.sock/\/var\/run\/mysqld\/mysqld.sock/" config/database.yml >> config/database.yml.af
mv config/database.yml.af config/database.yml

# mysql project_0_developmentデータベースを作成
echo 'create database project_0_development;' | mysql -u root

# Rails server起動
rails s
