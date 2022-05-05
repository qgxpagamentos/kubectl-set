# Github Action for Kubernetes CLI

Essa Action disponibiliza o comando `kubectl` para Github Actions.

## Uso

`.github/workflows/push.yml`

```yaml
on: push
name: deploy
jobs:
  deploy:
    name: deploy to cluster
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2

      - name: Install kubectl
        uses: qgxpagamentos/kubectl-set@v1
        with:
          base64-kube-config: ${{ secrets.KUBE_CONFIG_DATA }}
          kubectl-version: v1.22.5

      - name: Deploy Kubernetes cluster Service/Deployment
        run: |
          kubectl version
          kubectl apply -f deployment/kubernetes
```

## Secrets

`KUBE_CONFIG_DATA` – **requerido**: Um arquivo kubeconfig base64-encoded com as credenciais necessárias para o K8s acessar o cluster.
Exemplo de como gerar o arquivo base64-encoded:
```bash
cat $HOME/.kube/config | base64
```
[Inspiration](https://github.com/kodermax/kubectl-aws-eks)