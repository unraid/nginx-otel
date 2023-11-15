def main(dockerfile_path):
    """
    Extracts the tag from a Dockerfile that contains a FROM directive for the nginx-unprivileged image

    e.g.
    A dockerfile that had the line
    FROM docker.io/nginxinc/nginx-unprivileged:1.25.3-alpine3.18-slim
    would give
    1.25.3-alpine3.18-slim

    :return: The tag used for the nginx-unprivileged docker image
    """
    from_line_with_image_name = "FROM docker.io/nginxinc/nginx-unprivileged:"
    with open(dockerfile_path) as dockerfile:
        for line in dockerfile:
            if line.startswith(from_line_with_image_name):
                return line.removeprefix(from_line_with_image_name)
        exit(1)


if __name__ == "__main__":
    print(main("./Dockerfile"))
