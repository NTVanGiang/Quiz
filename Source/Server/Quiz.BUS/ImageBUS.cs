using System.Collections.Generic;

using Quiz.DAL;
using Quiz.Entity;

namespace Quiz.BUS
{
    public class ImageBUS
    {
        private ImageDAL obj = new ImageDAL();
        public List<Image> Image_GetByTop(string Top, string Where, string Order)
        {
            return obj.Image_GetByTop(Top, Where, Order);
        }
        public bool Image_Insert(Image data)
        {
            return obj.Image_Insert(data);
        }

        public bool Image_Update(Image data)
        {
            return obj.Image_Update(data);
        }

        public bool Image_Delete(string ID)
        {
            return obj.Image_Delete(ID);
        }
    }
}
