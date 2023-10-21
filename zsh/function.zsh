# Kill background process
function bgkill() {
  kill -9 $(jobs -l | head -1 | awk '{print $3}')
}

# Open Github PR: mypr <project_name>
function opr() {
  if [ -z "$1" ]; then
    open 'https://github.com/thinkei/frontend-core/pulls/phuongthuan'
  else
    project="$1"
    open "https://github.com/thinkei/${project}/pulls/phuongthuan"
  fi
}

# Open Circle CI: myci <project_name>
function oci() {
  if [ -z "$1" ]; then
    open 'https://app.circleci.com/pipelines/github/Thinkei?filter=mine'
  else
    project="$1"
    open "https://app.circleci.com/pipelines/github/Thinkei/${project}?filter=mine"
  fi
}

# Simple Git commit: mygcm "commit message"
function cgc() {
  # Check if a commit message is provided as an argument
  if [ -z "$1" ]; then
    echo "Please provide a commit message."
    return 1
  fi

  message="$1"
  git add .
  git commit -m "$message"
  git push origin HEAD
}

# EH function
# Exchange ebenToken

# get_session_token_by_email mobile t+swag1@employmenthero.com Khoa@10AM
get_session_token_by_email() {
  local sandbox="$1"
  local email="$2"
  local password="$3"
  curl -sS --location "https://$sandbox.staging.ehrocks.com/api/v2/sessions" \
    --header "Content-Type: application/json" \
    --header "Cookie: visid_incap_2661834=GDtswK8KQJa9372ILJMYRQctRWMAAAAAQUIPAAAAAADUXoBOfM9ApDQfC8Sm3BwV" \
    --data-raw "{\"data\": {\"attributes\": {\"email\": \"$email\", \"password\": \"$password\"}}}" \
    | jq -r ".data.attributes.session_token"
}

get_session_token() {
  curl -sS --location "https://mobile.staging.ehrocks.com/api/v2/sessions" \
    --header "Content-Type: application/json" \
    --header "Cookie: visid_incap_2661834=GDtswK8KQJa9372ILJMYRQctRWMAAAAAQUIPAAAAAADUXoBOfM9ApDQfC8Sm3BwV" \
    --data-raw "{\"data\": {\"attributes\": {\"email\": \"t+swag1@employmenthero.com\", \"password\": \"Khoa@10AM\"}}}" \
    | jq -r ".data.attributes.session_token"
}

get_eben_token() {
  local session_token
  session_token=$(get_session_token)

  local eben_access_token
  eben_access_token=$(
    curl -sS --location --request POST 'https://api.staging-ehfintech.com/auth/exchange' \
    --header 'content-type: application/json' \
    --header "authorization: Bearer $session_token" \
    | jq -r '.access_token')

  echo "{\"Authorization\":\"Bearer $eben_access_token\",\"X-EH-Session-Token\":\"$session_token\"}"
}

# get_bff_headers t+swag1@employmenthero.com Khoa@10AM
get_bff_headers() {
  local email="$1"
  local password="$2"

  local session_token
  session_token=$(
    curl -sS --location "https://mobile.staging.ehrocks.com/api/v2/sessions" \
      --header "Content-Type: application/json" \
      --header "Cookie: visid_incap_2661834=GDtswK8KQJa9372ILJMYRQctRWMAAAAAQUIPAAAAAADUXoBOfM9ApDQfC8Sm3BwV" \
      --data-raw "{\"data\": {\"attributes\": {\"email\": \"$email\", \"password\": \"$password\"}}}" \
      | jq -r ".data.attributes.session_token")

  local eben_access_token
  eben_access_token=$(
    curl -sS --location --request POST 'https://api.staging-ehfintech.com/auth/exchange' \
    --header 'content-type: application/json' \
    --header "authorization: Bearer $session_token" \
    | jq -r '.access_token')

  echo "{\"Authorization\":\"Bearer $eben_access_token\",\"X-EH-Session-Token\":\"$session_token\"}"
}
