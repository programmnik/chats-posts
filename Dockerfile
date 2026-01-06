# Используем LTS версию Node.js
FROM node:20-alpine

# Указываем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json
COPY package*.json ./

# Устанавливаем ВСЕ зависимости (включая prisma из devDependencies)
RUN npm ci

# Копируем Prisma схему
COPY prisma ./prisma/

# Генерируем Prisma клиент
RUN npx prisma generate

# Копируем остальное приложение (после генерации)
COPY . .

# Открыть порт
EXPOSE 3000

# Запускаем сервер
CMD [ "npm", "start" ]