# GRFICSv3 Contextual Network Transformation

This example handles a key difference between the original GRFICSv3 network and a Purdue-segmented topology:

A global replacement of:

```text
192.168.90.200 -> one new gateway
```

is not correct when the same original gateway is used by components that now belong to different zones.

The model used here is:

```text
Component -> Purdue Zone -> Gateway
```

Example:

```text
SIMULATOR -> FEED         -> 192.168.243.1
PLC       -> PLC          -> 192.168.243.17
HMI       -> HMI_CALDERA -> 192.168.243.33
CALDERA   -> HMI_CALDERA -> 192.168.243.33
```

## Files

```text
config/
├── network.env
├── components.env
├── ip-map.env
└── gateway-map.env

tools/
├── common.sh
├── inventory-network.sh
├── apply-network.sh
└── verify-network.sh
```

## Typical workflow

### 1. Discover IPs

```bash
./tools/inventory-network.sh
```

### 2. Define component zones

Edit:

```text
config/components.env
```

Example:

```bash
SIMULATOR_ZONE="FEED"
PLC_ZONE="PLC"
HMI_ZONE="HMI_CALDERA"
CALDERA_ZONE="HMI_CALDERA"
```

### 3. Define device IP mappings

Edit:

```text
config/ip-map.env
```

Format:

```text
COMPONENT|OLD_IP|NEW_IP|DESCRIPTION
```

### 4. Define contextual gateway mappings

Edit:

```text
config/gateway-map.env
```

Format:

```text
COMPONENT|OLD_GATEWAY|EXPECTED_NEW_GATEWAY|DESCRIPTION
```

Example:

```text
PLC|192.168.90.200|192.168.243.17|PLC gateway
```

The actual gateway used by the transformation is resolved from:

```text
Component -> Zone -> network.env
```

This avoids having two independent sources of truth.

### 5. Apply transformation per component

Examples:

```bash
./tools/apply-network.sh --component SIMULATOR --path simulation/
./tools/apply-network.sh --component PLC --path plc/
./tools/apply-network.sh --component HMI --path hmi/
./tools/apply-network.sh --component CALDERA --path caldera/
```

The script applies:

1. The component's device IP mapping.
2. The component's old gateway mapping.
3. The new gateway determined from the component's Purdue zone.

### 6. Validate

```bash
./tools/verify-network.sh
```

## Important limitation

This example assumes that a component can be identified by a directory or explicit path.

If the same file contains configuration for multiple Purdue zones, it should not be transformed with a simple component-level replacement. In that case, the file should be handled separately or with a more specific rule.

Also, the scripts intentionally operate on text files. Binary databases, SQLite files, compressed files, or generated database contents require a separate migration strategy.
