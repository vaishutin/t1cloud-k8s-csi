package driver

import (
	"k8s.io/klog"
)

type T1Driver struct {
	endpoint string
}

func CreateDriver(endpoint string) (*T1Driver, error) {
	drv := &T1Driver{
		endpoint: endpoint,
	}

	return drv, nil
}

func (drv *T1Driver) Setup(nodeId string) error {
	klog.Infof("setup")

	return nil
}
