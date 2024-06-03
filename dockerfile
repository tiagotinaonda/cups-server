# Use uma imagem base do Ubuntu
FROM ubuntu:24.04

# Instale o CUPS e suas dependências
RUN apt-get update && \
    apt-get install -y cups && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y cups-pdf && \
    apt-get clean

# Crie usuários e defina suas senhas, e adicione-os ao grupo lpadmin
RUN useradd usuario1 && \
    echo "usuario1:printer123" | chpasswd && \
    usermod -aG lpadmin usuario1 && \
    useradd usuario2 && \
    echo "usuario2:printer123" | chpasswd && \
    usermod -aG lpadmin usuario2
    
# Copie o arquivo de configuração do CUPS
COPY cupsd.conf /etc/cups/cupsd.conf
#COPY cupsd.conf /mnt/data/cups/cupsd.conf

# Exponha a porta 631
EXPOSE 631

# Inicie o CUPS
CMD ["/usr/sbin/cupsd", "-f"]