
# QuantumForge

**Post-Quantum Ledger Blockchain** dengan AI Guard, ML Oracle, dan IoT Machine-Human Bridge berbasis Model Context Protocol (MCP).

[![NIST FIPS 204](https://img.shields.io/badge/NIST-FIPS%20204%20(ML--DSA--87)-blue?style=for-the-badge)](https://csrc.nist.gov/pubs/fips/204/final)
[![MCP Protocol](https://img.shields.io/badge/MCP-Model%20Context%20Protocol-green?style=for-the-badge)](#)
[![Post-Quantum](https://img.shields.io/badge/Post--Quantum-Ready-purple?style=for-the-badge)](#)
[![EVM Compatible](https://img.shields.io/badge/EVM-Compatible-orange?style=for-the-badge)](#)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)

> **QuantumForge** menghubungkan dunia human, machine, dan quantum sensor secara real-time melalui jembatan otonom dua arah (Machine-Human Bridge) yang diamankan dengan kriptografi post-quantum.

---

## Fitur Utama

### 1. Post-Quantum Cryptography & Attestation
- **NIST FIPS 204 (ML-DSA-87)** Lattice Signature Attestation
- Target EVM Light Client State Transition & Minting
- Cryptographic Proof Generation & Ledger Commit
- QRNG nonces + Bell inequality parameters

### 2. Vault Reserve Matrix & Liquidity Floor
- Real-time liquidity floor status tracking
- Mathematical invariants untuk menjamin stabilitas cadangan

### 3. Proof Inspection & Verification Modal
- Inspeksi signature ML-DSA-87
- Verifikasi QRNG nonces
- Parameter Bell inequality
- Cryptographic hashes untuk setiap transfer yang selesai

### 4. Master Genesis Wallet & Audited Persistence
- **Master Genesis Wallet**: `0xD9a1E28224d6d047Eef8712dC97d11A9032b948e`
- Terintegrasi di seluruh jaringan EVM + STG-Chain
- Quantum Ledger audit report generator (export JSON & CSV yang immutable)

### 5. Multi-Surface Access & UI
- Navigasi khusus **Quantum Swap & Bridge** (badge PQCE BRIDGE)
- Integrasi penuh di **12 Pillars of STG**
  - Pilar #11 → **Quantum Swap Engine (Q-SWAP)** dengan dynamic badges

---

## Architecture Overview

```mermaid
graph TB
    subgraph Human Layer
        A[Human Intent] --> B[MCP Natural Language Interpreter]
    end

    subgraph AI Guard Layer
        B --> C[AI Guard + ML Oracle]
        C --> D[Model Context Protocol]
    end

    subgraph Blockchain Layer
        D --> E[Smart Contracts]
        E --> F[Post-Quantum Ledger]
        F --> G[ML-DSA-87 Signatures]
    end

    subgraph IoT & Quantum Layer
        H[IoT Devices & Quantum Sensors] --> I[Real-time Telemetry]
        I --> C
        C --> J[Machine-Human Bridge]
    end

    J --> A
    F --> K[Quantum Swap Engine]
    K --> L[Liquidity Floor & Vault]
