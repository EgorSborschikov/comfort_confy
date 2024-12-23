# ComfortConfy - Приложение для звонков и видеоконференций

## Краткое описание

ComfortConfy - кроссплатформенное приложение с открытым исходным кодом, позволяющее пользователям совершать звонки, создавать и участвовать в видеоконференциях.

## Функциональные возможности пользователей

- **Регистрация, авторизация и аутентификация**: Пользователи могут создавать аккаунты в приложении и осущесталять из-под них деятельность в приложении.
- **Персонализация профиля**: Пользователи могут настроить профиль на свое усмотрение.
- **Работа с другими пользователями**: Пользователи могут добавлять других пользователей в контакты, а также в чёрный список при необходимости
- **Создание и настройка видеоконференций**: Организация видеоконференции по заданным параметрам.
- **Роли участников**:
  - **Админ/создатель** - осуществляет полный контроль за процессом конференции.
  - **Модератор** - ассистент админа с ограниченным набором прав.
  - **Участник** - имеет базовый набор опций (управление микрофоном, веб-камерой, звуком), а также может быть назначен модератором.
- **Техническая поддержка**: Подсистема для ответов на вопросы пользователей.

## Технологии разработки программного обеспечения

- **Клиент-приложение**: Flutter.
- **База данных**:
  - **Основная**: PostgreSQL (для REST API).
  - **Вспомогательная**: Firebase (Аналитика использования приложения с сохранением кофенедциальности данных).
- **Объектно-реляционное представление (ORM)**: Python + SQLAlchemy + psycopg2.
- **REST API контрллер** - Python + FastAPI + pydantic
- **gRPC контролленр**: Go.
- **Техническая поддержка**: Телеграм бот 

## Безопасность

Доступ к данным пользователей и осуществление контроля над ними принадлежит ТОЛЬКО системным администраторам платформы.

## Установка

Приложение может быть установлено с помощью [GitHub](https://github.com) или [RuStore](https://rustore.ru). Также приложение доступно для запуска в веб-браузерах и внутри цифровой образовательной платформы "ДУМА".

## Документация

Для ознакомления с документацией приложения перейдите в [раздел документации](/docs) и прочтите все документы, которые он содержит.

## Лицензия

Программный продукт лицензирован и доступен для распространения в соответствии с порядком распрострения свободного ПО [MIT License](MIT_LICENSE).

## Дополнительная информация
- На данный момент реализация приложения происходит под мобильные операционные системы Android и IOS.

## Клонирование репозитория, изменение исходного кода и pull request'ы
- Использование исходного кода приложения и переиспользование его должно соответсовать требованиям лицензии приложения

### Подключение отредактированной версии к backend-сервису

- Чтобы подулючить отредатированное приложение к backend, необходимо, чтобы он находился на VDS (Virtual Destroyed Server)
- Неоьходимо изменить параметр API_BASE_URL в файле config.dart для подключения собственного REST API