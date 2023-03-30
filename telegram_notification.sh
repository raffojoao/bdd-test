#!/bin/sh

# Get the token from Travis environment vars and build the bot URL:
BOT_URL="https://api.telegram.org/bot5616652514:AAGJrfbzOTiai5v8kkHinfPTfnrwiW0fDw4/sendMessage"

TELEGRAM_CHAT_ID="-988599570"
# Set formatting for the message. Can be either "Markdown" or "HTML"
PARSE_MODE="Markdown"

MESSAGE="-------------------------------------
Travis build *${build_status}!*
\`Repository:  ${TRAVIS_REPO_SLUG}\`
\`Branch:      ${TRAVIS_BRANCH}\`
*Commit Msg:*
${TRAVIS_COMMIT_MESSAGE}
[Job Log here](${TRAVIS_JOB_WEB_URL})
--------------------------------------
"

# Use built-in Travis variables to check if all previous steps passed:
if [ $TRAVIS_TEST_RESULT -ne 0 ]; then
    build_status="failed"
else
    build_status="succeeded"
fi

# Define send message function. parse_mode can be changed to
# HTML, depending on how you want to format your message:
# send_msg () {
    # curl -s -X POST ${BOT_URL} -d chat_id=$TELEGRAM_CHAT_ID \
    #     -d text="${MESSAGE}" -d parse_mode=${PARSE_MODE}
# }

echo "Sending info message..."
  # send telegram chat message
  curl \
    --silent \
    -X POST "${BOT_URL}" \
    -d "chat_id=${TELEGRAM_CHAT_ID}" \
    -d "text=${MESSAGE}" \
    # -d "reply_to_message_id=${MESSAGE_ID}" \
    -d "parse_mode=Markdown" \
    -d "disable_web_page_preview=true" \
    >/dev/null


# Send message to the bot with some pertinent details about the job
# Note that for Markdown, you need to escape any backtick (inline-code)
# characters, since they're reserved in bash
# send_msg "
# -------------------------------------
# Travis build *${build_status}!*
# \`Repository:  ${TRAVIS_REPO_SLUG}\`
# \`Branch:      ${TRAVIS_BRANCH}\`
# *Commit Msg:*
# ${TRAVIS_COMMIT_MESSAGE}
# [Job Log here](${TRAVIS_JOB_WEB_URL})
# --------------------------------------
# "
