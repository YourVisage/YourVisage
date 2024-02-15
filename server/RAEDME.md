<h3 align="center">Your Visage</h3>

---
<p align="center"> Backend 
    <br>
</p>

## 📝 Агуулга

- [Систем](#about)
- [Шаардлага](#getting_started)
- [VSCode тохиргоо](#vscode)
- [Ажилуулах](#run)
- [Сервер](#deployment)
- [Ашигласан технологи](#built_using)


## 🧐 Систем <a name = "about"></a>

Your Visage Deep Fakes Ai Image Generator


## 🏁 Шаардлага <a name = "getting_started"></a>

Үйлдлийн систем дээр дараах зүйлсийг суулгасан байх шаардлагатай.

> Linux болон macOS систем дээр суулгах зааврууд.

#### SQLC

Sqlc нь SQL-ээс golang код үүсгэхэд ашиглана.

<details>
<summary>sqlc суулгах</summary>

#### MacOS

```sh
brew install sqlc
```

#### Linux

```sh
go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest
```

</details>

#### PROTOC

Protocol buffer хөрвүүлэгч, protoc нь .proto файлуудыг complile хийхэд ашиглана.

<details>
<summary>protoc суулгах</summary>

#### Linux ubuntu

```sh
 apt install -y protobuf-compiler
```

#### MacOS

```sh
 brew install protobuf
```

#### Linux bin

```sh
PB_REL="https://github.com/protocolbuffers/protobuf/releases"
```

```sh
curl -LO $PB_REL/download/v{{< param protoc-version >}}/protoc-{{< param protoc-version >}}-linux-x86_64.zip
```

```sh
unzip protoc-{{< param protoc-version >}}-linux-x86_64.zip -d $HOME/.local
```

```sh
export PATH="$PATH:$HOME/.local/bin"
```

</details>

#### PROTOLINT

.proto файлуудын lint.

<details>
<summary>protolint суулгах</summary>

#### Linux

```sh
go install github.com/yoheimuta/protolint/cmd/protolint@latest
```

#### MacOS

```sh
brew install protolint
```

</details>

#### GOLANGCI-LINT

.go файлууд буюу golang lint.

<details>
<summary>golangci-lint суулгах</summary>

#### Linux

```sh
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.55.2
```

#### MacOS

```sh
brew install golangci-lint
```

</details>

## 🗒️ VSCode тохиргоо <a name = "vscode"></a>

Дараах тохиргоо нь vscode дотор golangci lint ашиглахад хэрэгтэй.

#### Settings.json

```json
"go.lintFlags": ["--fast"],
"go.lintTool": "golangci-lint",
```

#### Extensions

- [Protolint](https://marketplace.visualstudio.com/items?itemName=Plex.vscode-protolint)
- [SQL Formatter](https://marketplace.visualstudio.com/items?itemName=adpyke.vscode-sql-formatter)
- [Proto 3](https://marketplace.visualstudio.com/items?itemName=zxh404.vscode-proto3)

## 🔧 Ажлуулах <a name = "run"></a>

<summary>Server directory татаж аваад хийх зүйлс</summary>

#### 1. Project- ийг ажлуулах command `conf-test.yml` файлийг ашиглан асна.
#### 2. Project- ийн тест файлыг ажиллуулахдаа make test гэж терминал дээр бичнэ
#### 3. Project- ийг татаж аваад шууд go mod tidy коммандыг ажилуулна.
```
make run
```

```
project
    └── conf
          └── conf-test.yml
```

#### 2. SQL-ээс golang код үүсгэх command үүссэн `.go` файлууд `db/sqlc/` фолдор дотор үүснэ.

```
make sqlc
```

```
project
    └── db
         └── sqlc
               ├── file.sqlc.go
               ├── file.sqlc.go
               └── file.sqlc.go
```

#### 3. `rpc/proto/` фолдор доторх `.proto` фaйлуудыг compile хийж golang код үүсгэнэ `rpc/pb/` фолдор дотор үүссэн `.go` файлууд орно.

```
make proto
```

```
project
    └── rpc
         └── pb
              ├── file.pb.go
              ├── file.pb.go
              └── file.pb.go
```

## 🚀 Сервер <a name = "deployment"></a>

- Rabbitmq болон postgresql ассан байх шаардлагатай.

- CI/CD github self hosted action ашиглаж байгаа учир runner server дээр ажиллаж байх ёстой.



## ⛏️ Ашигласан технологи <a name = "built_using"></a>

- [sqlc](https://github.com/sqlc-dev/sqlc)
- [grpc](https://github.com/grpc/grpc)
- [rabbitmq](https://github.com/wagslane/go-rabbitmq)
- [golang-migrate](https://github.com/golang-migrate/migrate)
- [pgx](https://github.com/jackc/pgx)
