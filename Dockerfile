# ใช้ Node.js image
FROM node:14

# ตั้ง working directory ใน container
WORKDIR /app

# คัดลอกไฟล์ package.json และ package-lock.json (ถ้ามี) เข้าสู่ container
COPY package*.json ./

# ติดตั้ง dependencies
RUN npm install

# คัดลอกไฟล์ทั้งหมดจากโฟลเดอร์ปัจจุบันเข้าไปใน container
COPY . .

# เปิดพอร์ต 3000
EXPOSE 3000

# รัน app.js หรือไฟล์ที่เป็น entry point ของแอป
CMD ["node", "app.js"]
