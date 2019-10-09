build:
	find policies/ -name '*.yml' -exec cat {} \; > policies/custodian.yml

clean:
	-rm policies/custodian.yml