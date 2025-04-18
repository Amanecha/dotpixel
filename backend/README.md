cd backend

docker build -t flask-pixel-app .

docker run -p 5000:5000 flask-pixel-app