// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Certificates {
    // Proprietário do contrato
    address public owner;

    // Estrutura de dados do certificado
    struct Certificate {
        string holderName; // Nome do titular
        string courseName; // Nome do curso ou certificado
        string issueDate;  // Data de emissão
        bool isValid;      // Validade do certificado
    }

    // Mapeamento de IDs para os certificados
    mapping(uint256 => Certificate) public certificates;

    // Evento para notificar a criação de um novo certificado
    event CertificateIssued(uint256 indexed certificateId, string holderName, string courseName);

    // Construtor: define o proprietário
    constructor() {
        owner = msg.sender;
    }

    // Modificador para restringir funções ao proprietário
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can execute this action.");
        _;
    }

    // Function to issue a new certificate
    function issueCertificate(
        uint256 _certificateId,
        string memory _holderName,
        string memory _courseName,
        string memory _issueDate
    ) public onlyOwner {
        require(!certificates[_certificateId].isValid, "Certificate with this ID certificate already exists.");

        certificates[_certificateId] = Certificate({
            holderName: _holderName,
            courseName: _courseName,
            issueDate: _issueDate,
            isValid: true
        });

        emit CertificateIssued(_certificateId, _holderName, _courseName);
    }

    // Função para invalidar um certificado
    function revokeCertificate(uint256 _certificateId) public onlyOwner {
        require(certificates[_certificateId].isValid, "Certificate doesn't found or doesn't exist.");
        certificates[_certificateId].isValid = false;
    }

    // Função para verificar se um certificado é válido
    function isCertificateValid(uint256 _certificateId) public view returns (bool) {
        return certificates[_certificateId].isValid;
    }
}
