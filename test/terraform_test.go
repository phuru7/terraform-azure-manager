package test

import (
    "testing"
    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestTerraformAzureExample(t *testing.T) {
    terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
        TerraformDir: "../environments/dev",
        Vars: map[string]interface{}{
            "environment": "test",
        },
    })

    defer terraform.Destroy(t, terraformOptions)
    terraform.InitAndApply(t, terraformOptions)

    // Verificar recursos creados
    resourceGroupName := terraform.Output(t, terraformOptions, "resource_group_name")
    assert.NotEmpty(t, resourceGroupName)

    // Verificar VMs
    vmInfo := terraform.OutputMap(t, terraformOptions, "vm_info")
    assert.NotEmpty(t, vmInfo)

    // Verificar Network
    networkInfo := terraform.OutputMap(t, terraformOptions, "network_info")
    assert.NotEmpty(t, networkInfo)
}
