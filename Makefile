all: env test packages

clean:
	bin/clean.sh

clean-cache:
	find . -name '*.pyc' | xargs rm
	find . -name '__pycache__' | xargs rm -rf

env:
	bin/env.sh

test:
	bin/test.sh

test-binary: test
	${SHELL} -c ". env/bin/activate; \
		pip install pytest; \
		bin/test-binary.sh"

test-binary-single:
	${SHELL} -c ". env/bin/activate; \
		pip install pytest; \
		bin/test-binary.sh $(test)"

packages:
	bin/packages.sh

binary: clean env packages
	${SHELL} -c ". env/bin/activate; \
		pip install pyinstaller==3.2.1; \
		pyinstaller binary/binary.spec"
