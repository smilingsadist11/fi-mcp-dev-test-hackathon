# 1. Authenticate with your Service Account
gcloud auth activate-service-account --key-file=sa-key.json

# 2. Set project & region variables
export PROJECT_ID=geni-project
export REGION=asia-south1         # or asia-south1, etc.
export SERVICE_NAME=fi-mcp-dev
export IMAGE=gcr.io/$PROJECT_ID/$SERVICE_NAME

# 3. Configure gcloud
gcloud config set project $PROJECT_ID
gcloud config set run/region $REGION

# 4. Enable necessary services
gcloud services enable run.googleapis.com containerregistry.googleapis.com

# 5. Authenticate Docker to push to gcr.io
gcloud auth configure-docker

# 6. Build Docker image locally
docker build --platform=linux/amd64 -t $IMAGE .

# 7. Push image to Google Container Registry
docker push $IMAGE

# 8. Deploy to Cloud Run using pushed image
gcloud run deploy $SERVICE_NAME \
  --image $IMAGE \
  --platform managed \
  --region $REGION \
  --allow-unauthenticated