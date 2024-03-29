FROM cgr.dev/chainguard/python:latest-dev as builder
ENV PATH="/ddays/venv/bin:$PATH"

WORKDIR /ddays
EXPOSE 4000

RUN python -m venv /ddays/venv

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

FROM cgr.dev/chainguard/python:latest

WORKDIR /ddays
ENV PATH="/venv/bin:$PATH"

COPY main.py ./
COPY templates ./templates
COPY --from=builder /ddays/venv /venv

ENTRYPOINT ["python", "/ddays/main.py"]

