# dcae-platform-documentation

Contains the public facing technical documentation for the dcae platform whose audiences include:

* Architects
* Component developers
* Operations

## Usage

### Local dev

This is a [Mkdocs](http://www.mkdocs.org/) project.  To serve a local version of the documentation to view your changes:

1. Install mkdocs and mkdocs-material:

    ```
    pip install mkdocs
    pip install mkdocs-material
    ```

2. Clone this repo
3. Run the following at the root of the cloned repo:

    ```
    mkdocs serve
    ```
4. View the page at `http://127.0.0.1:8000/`

### Publish

1. Generate the site:

    ```
    mkdocs build
    ```

2. Build and push the Docker image - note the repository and group `YOUR_NEXUS_DOCKER_REGISTRY/onap` can be customized and replaced:

    ```
    docker build -t YOUR_NEXUS_DOCKER_REGISTRY/onap/dcae-platform-documentation:latest .
    docker push YOUR_NEXUS_DOCKER_REGISTRY/onap/dcae-platform-documentation:latest
    ```

3. Run the Docker container:

    ```
    export DOCKER_HOST=tcp://<target docker host>
    # REVIEW: Does this always pull latest?
    docker pull YOUR_NEXUS_DOCKER_REGISTRY/onap/dcae-platform-documentation:latest
    docker run -d --name dpd -p 80:80 YOUR_NEXUS_DOCKER_REGISTRY/onap/dcae-platform-documentation:latest
    ```

