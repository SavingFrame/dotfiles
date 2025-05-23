function uv_poetry_install
    uv pip install --no-deps -r (POETRY_WARNINGS_EXPORT=false poetry export --without-hashes --with dev -f requirements.txt | psub)
    poetry install --only-root
end
