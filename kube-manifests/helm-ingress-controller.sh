# https://docs.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli


#Use a static public IP address
az aks show --resource-group myResourceGroup --name myAKSCluster --query nodeResourceGroup -o tsv

az network public-ip create \
    --resource-group MC_myResourceGroup_myAKSCluster_eastus \
    --name myAKSPublicIP \
    --sku Standard \
    --allocation-method static \
    --query publicIp.ipAddress \
    -o tsv

# Update ingress controller
DNS_LABEL="demo-aks-ingress"
NAMESPACE="ingress-basic"
STATIC_IP=<STATIC_IP>

helm upgrade nginx-ingress ingress-nginx/ingress-nginx \
  --namespace $NAMESPACE \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-dns-label-name"=$DNS_LABEL \
  --set controller.service.loadBalancerIP=$STATIC_IP


# Create an ingress controller in Azure Kubernetes Service (AKS)
# https://docs.microsoft.com/en-us/azure/aks/ingress-basic?tabs=azure-cli
