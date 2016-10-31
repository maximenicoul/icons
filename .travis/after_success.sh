#!/bin/bash

if [ -n "$GITHUB_API_KEY" ]; then
	cd "$TRAVIS_BUILD_DIR"
	if [ "$TRAVIS_PULL_REQUEST" == true ] && [ "$TRAVIS_BRANCH" != 'master' ]; then
		git checkout $TRAVIS_BRANCH
		git add src/
		git -c user.name='travis' -c user.email='travis' commit -m 'Fix svg icons'
		git push -f -q https://glorieux:$GITHUB_API_KEY@github.com/Talend/icons $TRAVIS_BRANCH &> /dev/null
		echo "✓ Push svg to $TRAVIS_BRANCH"
	fi
	cd "$TRAVIS_BUILD_DIR"
	curl -Lo travis_after_all.py https://git.io/travis_after_all
	python travis_after_all.py
	export $(cat .to_export_back) &> /dev/null
fi
