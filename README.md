## ZTM Docker Repository

This repository provides a Dockerfile and instructions for building a Docker image for Zero Trust Mesh (ZTM), whose main repository can be found at [ZTM GitHub Repository](https://github.com/flomesh-io/ztm).

### Prerequisites

- Docker installed on your system.

### Building the Docker Image

To build the Docker image for ZTM, follow these steps:

1. **Clone the Repository**

   ```sh
   git clone https://github.com/addozhang/ztm-docker.git
   cd ztm-docker
   ```

2. **Build the Docker Image**

   ```sh
   docker build -t ztm .
   ```

### Running the Docker Containers

By default, the Docker image starts the ZTM Agent. To run the ZTM Hub or ZTM CA, you need to modify the entrypoint.

- **Running the ZTM Agent Container (default)**

  ```sh
  docker run -d --name ztm-agent ztm
  ```

- **Running the ZTM Hub Container**

  ```sh
  docker run -d --name ztm-hub --entrypoint ztm ztm run hub --listen '0.0.0.0:8888' --ca 'localhost:9999'
  ```

- **Running the ZTM CA Container**

  ```sh
  docker run -d --name ztm-ca --entrypoint ztm ztm run ca --listen '127.0.0.1:9999' --database '/root/ztm-ca.db'
  ```

### Customizing the Build

You can customize the Docker image by modifying the Dockerfile and adding any necessary configuration files or dependencies.

### Contributing

Contributions are welcome! Please submit pull requests or open issues to help improve this project.
