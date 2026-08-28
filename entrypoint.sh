#!/bin/sh
set -e

export BUTLER_API_KEY=$BUTLER_CREDENTIALS

versionArgument=""
only_changes=""
if [ "$IF_CHANGED" = "true" ]
then
    only_changes="--if-changed"
fi

if [ "$VERSION" != "" ]
then
    versionArgument="--userversion ${VERSION}"
elif [ "$VERSION_FILE" != "" ]
then
    versionArgument="--userversion-file ${VERSION_FILE}"
fi

echo "butler push \"$PACKAGE\" $ITCH_USER/$ITCH_GAME:$CHANNEL ${versionArgument} ${only_changes}"
butler push-preview --changes-only "$PACKAGE" $ITCH_USER/$ITCH_GAME:$CHANNEL

butler push "$PACKAGE" $ITCH_USER/$ITCH_GAME:$CHANNEL ${versionArgument} ${only_changes}
