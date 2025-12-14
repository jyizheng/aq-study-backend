# 0. 添加 Supabase 仓库
echo 'deb [trusted=yes] https://apt.fury.io/supabase/ /' | sudo tee /etc/apt/sources.list.d/supabase.list

# 2. 更新并安装
sudo apt-get update
sudo apt-get install supabase

